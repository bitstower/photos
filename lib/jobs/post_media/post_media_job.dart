import 'package:isar/isar.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../job.dart';
import '../step.dart';
import '../../models/media.dart';
import '../../services/database.dart';
import 'post_media_context.dart';

@sealed
class PostMediaJob extends Job<PostMediaContext> {
  final _log = Logger('AssetStep');

  final Database _database;
  final List<Step<PostMediaContext>> _steps;

  PostMediaJob(
    this._database,
    super.context,
    this._steps,
  );

  @override
  Future execute() async {
    await super.execute();

    _log.info('PostMediaJob started');

    int? mediaId;

    mediaId = context.getMediaId();
    if (mediaId != null) {
      _log.info('Media found in context, mediaId=$mediaId');
      await _processMedia(mediaId, context.getStepIdx());
    }

    mediaId = await _getNextMediaId();
    while (mediaId != null) {
      await _processMedia(mediaId, 0);
      mediaId = await _getNextMediaId();
    }

    _log.info('PostMediaJob completed');
  }

  Future _processMedia(int mediaId, int stepIdx) async {
    await context.setMediaId(mediaId);
    for (var i = stepIdx; i < _steps.length; i++) {
      await context.setStepIdx(i);
      await _steps[i].execute(context);
    }
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
