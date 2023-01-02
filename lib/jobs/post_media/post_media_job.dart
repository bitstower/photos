import 'package:isar/isar.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:photos/jobs/post_media/asset_step.dart';
import 'package:photos/jobs/post_media/journal_step.dart';
import 'package:photos/journal/journal_repository.dart';

import '../job.dart';
import '../../models/media.dart';
import '../../services/database.dart';
import '../../services/s3fs.dart' as s3fs;
import 'broadcast_step.dart';
import 'post_media_context.dart';

@sealed
class PostMediaJob extends Job<PostMediaContext> {
  final _log = Logger('AssetStep');

  final Database _database;

  final JournalRepository _journalRepository;

  final AssetStep _smThumbAssetStep;
  final AssetStep _mdThumbAssetStep;
  final AssetStep _lgThumbAssetStep;
  final AssetStep _originAssetStep;
  final JournalStep _journalStep;
  final BroadcastStep _broadcastStep;

  PostMediaJob(
    this._database,
    super.context,
    this._journalRepository,
    this._smThumbAssetStep,
    this._mdThumbAssetStep,
    this._lgThumbAssetStep,
    this._originAssetStep,
    this._journalStep,
    this._broadcastStep,
  );

  @override
  Future execute() async {
    await super.execute();

    _log.info('PostMediaJob started');

    int? mediaId;

    mediaId = context.getMediaId();
    if (mediaId != null) {
      _log.info('Media found in context, mediaId=$mediaId');
      await _processMedia(mediaId);
    }

    mediaId = await _getNextMediaId();
    while (mediaId != null) {
      await _processMedia(mediaId);
      mediaId = await _getNextMediaId();
    }

    await _journalRepository.push();

    _log.info('PostMediaJob completed, totalMs=${s3fs.total}');
  }

  Future _processMedia(int mediaId) async {
    await context.setMediaId(mediaId);

    List<Future> futures1 = [];
    futures1.add(_smThumbAssetStep.execute(context));
    futures1.add(_mdThumbAssetStep.execute(context));
    futures1.add(_lgThumbAssetStep.execute(context));
    futures1.add(_originAssetStep.execute(context));
    await Future.wait(futures1);

    List<Future> futures2 = [];
    futures2.add(_journalStep.execute(context));
    futures2.add(_broadcastStep.execute(context));
    await Future.wait(futures2);

    await context.reset();
  }

  Future<int?> _getNextMediaId() async {
    final connection = _database.open();
    final result = await connection.medias
        .where()
        .uploadedDeletedEqualTo(false, false)
        .limit(1)
        .idProperty()
        .findAll();

    final mediaId = result.isNotEmpty ? result.single : null;

    if (mediaId != null) {
      _log.info('Next media in queue, mediaId=$mediaId');
    } else {
      _log.info('Queue is empty');
    }

    return mediaId;
  }
}
