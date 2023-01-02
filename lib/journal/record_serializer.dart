import 'dart:typed_data';

import '../utils/serializer.dart';
import 'record.dart';

class RecordSerializer extends Serializer<Record> {
  final _type = 0;
  final _timestamp = 1;
  final _schema = 2;
  final _payload = 3;

  final PostMediaSerializer _postMediaSerializer;

  RecordSerializer(this._postMediaSerializer);

  @override
  Record fromJson(Map json) {
    return Record(
      type: RecordType.fromNum(json[_type] as int),
      payload: _postMediaSerializer.fromJson(json[_payload] as Map),
      timestamp: json[_timestamp] as int,
      schema: json[_schema] as int,
    );
  }

  @override
  Map toJson(Record src) {
    var json = <int, dynamic>{};
    json[_type] = src.type.idx;
    json[_timestamp] = src.timestamp;
    json[_schema] = src.schema;
    json[_payload] = _postMediaSerializer.toJson(src.payload);
    return Map.unmodifiable(json);
  }
}

class PostMediaSerializer extends Serializer<PostMedia> {
  final _type = 0;
  final _taken = 1;
  final _orientatedWidth = 2;
  final _orientatedHeight = 3;
  final _orientation = 4;
  final _duration = 5;

  final _originAsset = 6;
  final _smThumbAsset = 7;
  final _mdThumbAsset = 8;
  final _lgThumbAsset = 9;

  final AssetSerializer _assetSerializer;

  PostMediaSerializer(this._assetSerializer);

  @override
  PostMedia fromJson(Map json) {
    return PostMedia(
      type: json[_type] as int,
      taken: json[_taken] as int,
      orientatedWidth: json[_orientatedWidth] as int,
      orientatedHeight: json[_orientatedHeight] as int,
      orientation: json[_orientation] as int,
      duration: json[_duration] as int,
      originAsset: _assetSerializer.fromJson(json[_originAsset]),
      smThumbAsset: _assetSerializer.fromJson(json[_smThumbAsset]),
      mdThumbAsset: _assetSerializer.fromJson(json[_mdThumbAsset]),
      lgThumbAsset: _assetSerializer.fromJson(json[_lgThumbAsset]),
    );
  }

  @override
  Map toJson(PostMedia src) {
    var json = <int, dynamic>{};
    json[_type] = src.type;
    json[_taken] = src.taken;
    json[_orientatedWidth] = src.orientatedWidth;
    json[_orientatedHeight] = src.orientatedHeight;
    json[_orientation] = src.orientation;
    json[_duration] = src.duration;
    json[_originAsset] = _assetSerializer.toJson(src.originAsset);
    json[_smThumbAsset] = _assetSerializer.toJson(src.smThumbAsset);
    json[_mdThumbAsset] = _assetSerializer.toJson(src.mdThumbAsset);
    json[_lgThumbAsset] = _assetSerializer.toJson(src.lgThumbAsset);
    return Map.unmodifiable(json);
  }
}

class AssetSerializer extends Serializer<Asset> {
  final _uuid = 0;
  final _secretKey = 1;
  final _secretHeader = 2;
  final _checksum = 3;
  final _fileSize = 4;
  final _fileType = 5;

  @override
  Asset fromJson(Map json) {
    return Asset(
      uuid: json[_uuid] as String,
      secretKey: json[_secretKey] as Uint8List,
      secretHeader: json[_secretHeader] as Uint8List,
      checksum: json[_checksum] as String,
      fileSize: json[_fileSize] as int,
      fileType: json[_fileType] as String,
    );
  }

  @override
  Map toJson(Asset src) {
    var json = <int, dynamic>{};
    json[_uuid] = src.uuid;
    json[_secretKey] = src.secretKey;
    json[_secretHeader] = src.secretHeader;
    json[_checksum] = src.checksum;
    json[_fileSize] = src.fileSize;
    json[_fileType] = src.fileType;
    return Map.unmodifiable(json);
  }
}
