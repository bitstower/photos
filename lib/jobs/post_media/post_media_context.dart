import 'package:meta/meta.dart';
import 'package:photos/jobs/post_media/asset_step_result.dart';

import '../../utils/context.dart';

@sealed
class PostMediaContext extends Context {
  static const _mediaId = 'mediaId';

  PostMediaContext(super.jarId, super.jarDao);

  AssetStepResult get smThumbAssetStep =>
      AssetStepResult('smThumbAssetStep', getValue, setValue);
  AssetStepResult get mdThumbAssetStep =>
      AssetStepResult('mdThumbAssetStep', getValue, setValue);
  AssetStepResult get lgThumbAssetStep =>
      AssetStepResult('lgThumbAssetStep', getValue, setValue);
  AssetStepResult get originAssetStep =>
      AssetStepResult('originAssetStep', getValue, setValue);

  int? getMediaId() => getValue(_mediaId);
  Future setMediaId(int value) => setValue(_mediaId, value);
}
