import 'package:meta/meta.dart';
import 'package:photos/jobs/post_media/asset_step_result.dart';
import 'package:photos/jobs/post_media/post_media_context.dart';
import 'package:photos/models/media.dart';
import 'package:photos/services/media_dao.dart';
import 'package:photos/jobs/step_result.dart';

import '../step.dart';

@sealed
class BroadcastStep extends Step<PostMediaContext> {
  final MediaDao _mediaDao;

  BroadcastStep(this._mediaDao);

  @override
  Future execute(PostMediaContext context) async {
    final mediaId = context.getMediaId();
    assert(mediaId != null);

    final media = await _mediaDao.getById(mediaId!);
    assert(media != null);

    media!
      ..remoteSmThumb = RemoteAsset()
      ..remoteMdThumb = RemoteAsset()
      ..remoteLgThumb = RemoteAsset()
      ..remoteOrigin = RemoteAsset()
      ..uploaded = true;

    copyAsset(context.smThumbAssetStep, media.remoteSmThumb!);
    copyAsset(context.mdThumbAssetStep, media.remoteMdThumb!);
    copyAsset(context.lgThumbAssetStep, media.remoteLgThumb!);
    copyAsset(context.originAssetStep, media.remoteOrigin!);

    await _mediaDao.put(media);
  }

  copyAsset(AssetStepResult src, RemoteAsset dst) {
    dst
      ..uuid = src.getUuid()!
      ..secretKey = src.getSecretKey()!
      ..secretHeader = src.getSecretHeader()!
      ..fileSize = src.getFileSize()!
      ..fileType = src.getFileType()!;
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
