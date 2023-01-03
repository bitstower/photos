import 'dart:io';

import 'package:meta/meta.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photos/utils/context.dart';
import 'package:photos/utils/image_resolution.dart';
import 'package:photos/utils/image_size.dart';

import 'asset_step.dart';
import 'asset_step_result.dart';
import 'post_media_context.dart';
import '../../models/media.dart';

@sealed
class ThumbAssetStep extends AssetStep {
  final ImageResolution _resolution;

  ThumbAssetStep(
    this._resolution,
    super.database,
    super.secretBox,
    super.uuid,
    super.checksum,
    super.tmpDir,
    super.s3fs,
  );

  @override
  Future<File> getAsset(Context<PostMediaContext> context) async {
    final result = getResult(context);

    final uuid = result.uuid;
    assert(uuid != null);

    final mediaId = context.data.mediaId;
    assert(mediaId != null);

    final connection = database.open();
    final media = await connection.medias.get(mediaId!);

    final localId = media?.localOrigin?.localId;
    assert(localId != null);

    final localAsset = await AssetEntity.fromId(localId!);
    assert(localAsset != null && await localAsset.exists);

    final mediaSize = ImageSize(
      localAsset!.orientatedWidth,
      localAsset.orientatedHeight,
    );
    final thumbSize = _resolution.findClosestSize(mediaSize);

    final thumbBytes = await localAsset.thumbnailDataWithSize(
      ThumbnailSize(
        thumbSize.width,
        thumbSize.height,
      ),
      quality: _resolution.quality,
    );
    assert(thumbBytes != null);

    final thumbFile = await getTmpFile(uuid!, 'jpg');
    await thumbFile.writeAsBytes(
      thumbBytes!,
      mode: FileMode.write,
      flush: true,
    );

    log.info(
      'Generated thumbnail, '
      'mediaId=$mediaId localId=$localId '
      'width=${thumbSize.width} height=${thumbSize.height} '
      'bytes=${thumbBytes.lengthInBytes}',
    );

    return thumbFile;
  }

  @override
  bool shouldKeepAsset() {
    return false;
  }

  @override
  AssetStepResult getResult(Context<PostMediaContext> context) {
    switch (_resolution) {
      case ImageResolution.sd:
        return context.data.smThumbAssetStep;
      case ImageResolution.hd:
        return context.data.mdThumbAssetStep;
      case ImageResolution.qhd:
        return context.data.lgThumbAssetStep;
      default:
        throw Exception('Unknown resolution');
    }
  }
}
