import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:photos/journal/journal_context.dart';

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
        uuid: remoteInfo.deviceUuid,
        readOffset: _context.getReadOffset(remoteInfo.deviceUuid),
        own: remoteInfo.deviceUuid == thisDeviceUuid,
        directory: directory,
        remoteFileSize: remoteInfo.fileSize,
      );
      if (!hasOwn) {
        hasOwn = tracker.own;
      }
      trackers.add(tracker);
    }

    if (!hasOwn) {
      trackers.add(JournalTracker(
        uuid: thisDeviceUuid,
        readOffset: _context.getReadOffset(thisDeviceUuid),
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
      if (tracker.cached && tracker.unread) {
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

class JournalTracker {
  final String uuid;

  final int remoteFileSize;
  final int readOffset;
  final bool own;

  final Directory directory;

  JournalTracker({
    required this.uuid,
    required this.readOffset,
    required this.own,
    required this.directory,
    this.remoteFileSize = 0,
  });

  bool get outdated => remoteFileSize != file.lengthSync();
  bool get cached => file.existsSync();
  bool get unread => readOffset < file.lengthSync();
  File get file => File('${directory.path}/$uuid');
  String get uri => '/journal/$uuid';
}
