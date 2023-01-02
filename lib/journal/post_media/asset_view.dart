import 'package:flutter/foundation.dart';

class AssetView {
  final _uuid = 0;
  final _secretKey = 1;
  final _secretHeader = 2;
  final _checksum = 3;
  final _fileSize = 4;
  final _fileType = 5;

  final Map<int, dynamic> properties;

  AssetView(this.properties);

  String getUuid() => properties[_uuid];
  Uint8List getSecretKey() => properties[_secretKey];
  Uint8List getSecretHeader() => properties[_secretHeader];
  String getChecksum() => properties[_checksum];
  int getFileSize() => properties[_fileSize];
  String getFileType() => properties[_fileType];

  setUuid(String val) => properties[_uuid] = val;
  setSecretKey(Uint8List val) => properties[_secretKey] = val;
  setSecretHeader(Uint8List val) => properties[_secretHeader] = val;
  setChecksum(String val) => properties[_checksum] = val;
  setFileSize(int val) => properties[_fileSize] = val;
  setFileType(String val) => properties[_fileType] = val;
}
