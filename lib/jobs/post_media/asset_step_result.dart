import 'package:flutter/foundation.dart';

import '../step_result.dart';

class AssetStepResult extends StepResult {
  static const _uuid = 'uuid';
  static const _secretKey = 'secretKey';
  static const _secretHeader = 'secretHeader';
  static const _checksum = 'checksum';
  static const _fileSize = 'fileSize';
  static const _fileType = 'fileType';

  AssetStepResult(
    super.prefix,
    super.getValueCallback,
    super.setValueCallback,
  );

  String? getUuid() => getValue(_uuid);
  Uint8List? getSecretKey() => getValue(_secretKey);
  Uint8List? getSecretHeader() => getValue(_secretHeader);
  int? getFileSize() => getValue(_fileSize);
  String? getFileType() => getValue(_fileType);
  String? getChecksum() => getValue(_checksum);

  Future setUuid(String value) => setValue(_uuid, value);
  Future setSecretKey(Uint8List value) => setValue(_secretKey, value);
  Future setSecretHeader(Uint8List value) => setValue(_secretHeader, value);
  Future setFileSize(int value) => setValue(_fileSize, value);
  Future setFileType(String value) => setValue(_fileType, value);
  Future setChecksum(String value) => setValue(_checksum, value);
}
