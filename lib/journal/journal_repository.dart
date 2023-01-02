import 'package:path_provider/path_provider.dart';
import 'package:photos/journal/journal_context.dart';
import 'package:photos/journal/journal_tracker.dart';
import 'package:photos/journal/read_journal.dart';
import 'package:photos/journal/write_journal.dart';

import '../services/account.dart';
import '../services/s3fs.dart';
import 'journal.dart';

class JournalRepository {
  final Account _account;
  final S3Fs _s3fs;

  final JournalContext _context;

  JournalRepository(this._context, this._account, this._s3fs);

  Future<List<JournalTracker>> _getTrackers() async {
    final thisDeviceUuid = await _account.getDeviceUuid();
    final remoteInfos = await _account.getRemoteJournalInfos();
    final directory = await getApplicationSupportDirectory();

    final trackers = <JournalTracker>[];

    var hasOwn = false;

    for (var remoteInfo in remoteInfos) {
      var tracker = JournalTracker(
        remoteInfo.deviceUuid,
        _context.getReadOffset(remoteInfo.deviceUuid),
        remoteFileSize: remoteInfo.fileSize,
        own: remoteInfo.deviceUuid == thisDeviceUuid,
        directory: directory,
      );
      if (!hasOwn) {
        hasOwn = tracker.own;
      }
      trackers.add(tracker);
    }

    if (!hasOwn) {
      trackers.add(JournalTracker(
        thisDeviceUuid,
        _context.getReadOffset(thisDeviceUuid),
        own: true,
        directory: directory,
      ));
    }

    return trackers;
  }

  Future<JournalTracker> _getOwnTracker() async {
    return (await _getTrackers()).firstWhere((tracker) => tracker.own);
  }

  Future<List<Journal>> getUnreadJournals() async {
    var trackers = await _getTrackers();

    final unread = <ReadJournal>[];

    for (var tracker in trackers) {
      if (tracker.unread) {
        unread.add(ReadJournal(tracker.file, tracker.readOffset));
        await _context.setReadOffset(
          tracker.uuid,
          tracker.file.lengthSync(),
        );
      }
    }

    return unread;
  }

  Future<Journal> getOwnJournal() async {
    final tracker = await _getOwnTracker();
    return WriteJournal(tracker.file, tracker.readOffset);
  }

  Future push() async {
    final tracker = await _getOwnTracker();
    if (tracker.outdated) {
      await _s3fs.put(tracker.uri, tracker.file);
    }
  }

  Future pull() async {
    final trackers = await _getTrackers();
    for (var tracker in trackers) {
      if (!tracker.own && tracker.outdated) {
        // get
        // await _s3fs.put(tracker.uri, tracker.file);
      }
    }
  }
}
