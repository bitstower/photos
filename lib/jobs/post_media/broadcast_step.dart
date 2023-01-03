import 'package:meta/meta.dart';
import 'package:photos/jobs/post_media/asset_step_result.dart';
import 'package:photos/jobs/post_media/post_media_context.dart';
import 'package:photos/models/media.dart';
import 'package:photos/services/media_dao.dart';
import 'package:photos/utils/context.dart';
import 'package:photos/utils/dummy.dart';

import '../step.dart';

@sealed
class BroadcastStep extends Step<PostMediaContext, Dummy> {
  final MediaDao _mediaDao;

  BroadcastStep(this._mediaDao);

  @override
  Future execute(Context<PostMediaContext> context) async {
    final mediaId = context.data.mediaId;
    assert(mediaId != null);

    final media = await _mediaDao.getById(mediaId!);
    assert(media != null);

    media!
      ..remoteSmThumb = _buildAsset(context.data.smThumbAssetStep)
      ..remoteMdThumb = _buildAsset(context.data.mdThumbAssetStep)
      ..remoteLgThumb = _buildAsset(context.data.lgThumbAssetStep)
      ..remoteOrigin = _buildAsset(context.data.originAssetStep)
      ..uploaded = true;

    await _mediaDao.put(media);
  }

  RemoteAsset _buildAsset(AssetStepResult src) {
    return RemoteAsset()
      ..uuid = src.uuid!
      ..secretKey = src.secretKey!
      ..secretHeader = src.secretHeader!
      ..fileSize = src.fileSize!
      ..fileType = src.fileType!;
  }

  @override
  Dummy getResult(Context<PostMediaContext> context) {
    throw UnimplementedError();
  }
}
