import 'package:photos/jobs/post_media/asset_step_result.dart';
import 'package:photos/utils/serializer.dart';

class PostMediaContext {
  int? mediaId;

  AssetStepResult smThumbAssetStep;
  AssetStepResult mdThumbAssetStep;
  AssetStepResult lgThumbAssetStep;
  AssetStepResult originAssetStep;

  PostMediaContext({
    required this.mediaId,
    required this.smThumbAssetStep,
    required this.mdThumbAssetStep,
    required this.lgThumbAssetStep,
    required this.originAssetStep,
  });
}

class PostMediaContextSerializer extends Serializer<PostMediaContext> {
  final _mediaId = 'mediaId';
  final _smThumbAssetStep = 'smThumbAssetStep';
  final _mdThumbAssetStep = 'mdThumbAssetStep';
  final _lgThumbAssetStep = 'lgThumbAssetStep';
  final _originAssetStep = 'originAssetStep';

  final AssetStepResultSerializer _assetSerializer;

  PostMediaContextSerializer(this._assetSerializer);

  @override
  PostMediaContext fromJson(Map json) {
    var smThumb = json[_smThumbAssetStep] as Map<String, dynamic>? ?? {};
    var mdThumb = json[_mdThumbAssetStep] as Map<String, dynamic>? ?? {};
    var lgThumb = json[_lgThumbAssetStep] as Map<String, dynamic>? ?? {};
    var origin = json[_originAssetStep] as Map<String, dynamic>? ?? {};

    return PostMediaContext(
      mediaId: json[_mediaId] as int?,
      smThumbAssetStep: _assetSerializer.fromJson(smThumb),
      mdThumbAssetStep: _assetSerializer.fromJson(mdThumb),
      lgThumbAssetStep: _assetSerializer.fromJson(lgThumb),
      originAssetStep: _assetSerializer.fromJson(origin),
    );
  }

  @override
  Map toJson(PostMediaContext src) {
    var json = <String, dynamic>{};
    json[_mediaId] = src.mediaId;
    json[_smThumbAssetStep] = _assetSerializer.toJson(src.smThumbAssetStep);
    json[_mdThumbAssetStep] = _assetSerializer.toJson(src.mdThumbAssetStep);
    json[_lgThumbAssetStep] = _assetSerializer.toJson(src.lgThumbAssetStep);
    json[_originAssetStep] = _assetSerializer.toJson(src.originAssetStep);
    return Map.unmodifiable(json);
  }
}
