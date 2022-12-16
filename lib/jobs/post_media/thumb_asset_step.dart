import 'dart:io';

import 'package:meta/meta.dart';
import 'package:photo_manager/photo_manager.dart';
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
  );

  @override
  Future<File> getAsset(PostMediaContext context) async {
    final result = getResult(context);

    final uuid = result.getUuid();
    assert(uuid != null);

    final mediaId = context.getMediaId();
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

    return thumbFile;
  }

  @override
  bool shouldKeepAsset() {
    return false;
  }

  @override
  AssetStepResult getResult(PostMediaContext context) {
    switch (_resolution) {
      case ImageResolution.sd:
        return context.smThumbAssetStep;
      case ImageResolution.hd:
        return context.mdThumbAssetStep;
      case ImageResolution.qhd:
        return context.lgThumbAssetStep;
      default:
        throw Exception('Unknown resolution');
    }
  }
}
