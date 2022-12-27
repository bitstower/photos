import 'package:photos/jobs/post_media/post_media_context.dart';
import 'package:photos/models/media.dart';
import 'package:photos/services/media_dao.dart';
import 'package:photos/jobs/step_result.dart';

import '../step.dart';

class BroadcastStep extends Step<PostMediaContext> {
  final MediaDao _mediaDao;

  BroadcastStep(this._mediaDao);

  @override
  Future execute(PostMediaContext context) async {
    final mediaId = context.getMediaId();
    assert(mediaId != null);

    // TODO update asset objects

    final media = await _mediaDao.getById(mediaId!);
    assert(media != null);

    media!.uploaded = true;

    await _mediaDao.put(media);
  }

  @override
  Future revert(PostMediaContext context) {
    throw UnimplementedError();
  }

  @override
  StepResult getResult(PostMediaContext context) {
    throw UnimplementedError();
  }
}
