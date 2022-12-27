import 'dart:io';

import 'package:meta/meta.dart';
import 'package:photo_manager/photo_manager.dart';

import 'asset_step_result.dart';
import 'asset_step.dart';
import 'post_media_context.dart';
import '../../models/media.dart';

@sealed
class OriginAssetStep extends AssetStep {
  OriginAssetStep(
    super.database,
    super.secretBox,
    super.uuid,
    super.checksum,
    super.tmpDir,
    super.s3fs,
  );

  @override
  Future<File> getAsset(PostMediaContext context) async {
    final mediaId = context.getMediaId();
    assert(mediaId != null);

    final conn = database.open();
    final media = await conn.medias.get(mediaId!);

    final localId = media?.localOrigin?.localId;
    assert(localId != null);

    final localAsset = await AssetEntity.fromId(localId!);
    assert(localAsset != null && await localAsset.exists);

    final localFile = await localAsset?.originFile;
    assert(localFile != null);

    log.info('Accessed origin file, mediaId=$mediaId localId=$localId');

    return localFile!;
  }

  @override
  bool shouldKeepAsset() {
    return true;
  }

  @override
  AssetStepResult getResult(PostMediaContext context) {
    return context.originAssetStep;
  }
}
