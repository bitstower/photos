import 'package:flutter/foundation.dart';
import 'package:photos/utils/serializer.dart';

class AssetStepResult {
  String? uuid;
  Uint8List? secretKey;
  Uint8List? secretHeader;
  String? checksum;
  int? fileSize;
  String? fileType;

  AssetStepResult({
    required this.uuid,
    required this.secretKey,
    required this.secretHeader,
    required this.checksum,
    required this.fileSize,
    required this.fileType,
  });
}

class AssetStepResultSerializer extends Serializer<AssetStepResult> {
  final _uuid = 'uuid';
  final _secretKey = 'secretKey';
  final _secretHeader = 'secretHeader';
  final _checksum = 'checksum';
  final _fileSize = 'fileSize';
  final _fileType = 'fileType';

  @override
  AssetStepResult fromJson(Map json) {
    return AssetStepResult(
      uuid: json[_uuid] as String?,
      secretKey: json[_secretKey] as Uint8List?,
      secretHeader: json[_secretHeader] as Uint8List?,
      checksum: json[_checksum] as String?,
      fileSize: json[_fileSize] as int?,
      fileType: json[_fileType] as String?,
    );
  }

  @override
  Map toJson(AssetStepResult src) {
    var json = <String, dynamic>{};
    json[_uuid] = src.uuid;
    json[_secretKey] = src.secretKey;
    json[_secretHeader] = src.secretHeader;
    json[_checksum] = src.checksum;
    json[_fileSize] = src.fileSize;
    json[_fileType] = src.fileType;
    return Map.unmodifiable(json);
  }
}
