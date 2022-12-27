import 'dart:convert';
import 'dart:io';

import 'package:aws_common/aws_common.dart';
import 'package:flutter/foundation.dart';
import 'package:photos/services/secret_box.dart';
import 'package:photos/utils/s3/s3.dart';
import 'package:photos/utils/s3/s3_factory.dart';
import 'package:photos/utils/tmp_dir.dart';
import 'package:uuid/uuid.dart';

import '../utils/s3/secret.dart';

int total = 0;

class S3Fs {
  static const _encExtension = 'enc';

  final S3Factory _s3Factory;
  final SecretBox _secretBox;
  final TmpDir _tmpDir;
  final Uuid _uuid;

  S3? _s3;

  S3Fs(this._s3Factory, this._secretBox, this._tmpDir, this._uuid);

  S3 _getS3() {
    return _s3 ??= _s3Factory.build();
  }

  // TODO cancelable
  Future<Secret> put(String path, File file) async {
    final fileEnc = await _tmpDir.getFile(_uuid.v4(), _encExtension);

    late Uint8List secretKey;
    late Uint8List secretHeader;
    late AWSBaseHttpResponse response;

    try {
      var s = Stopwatch();
      s.start();
      secretKey = _secretBox.generateKey();
      secretHeader = await _secretBox.encrypt(file, fileEnc, secretKey);
      s.stop();
      total += s.elapsedMilliseconds;
      response = await _getS3().put(fileEnc, path);
    } finally {
      if (await fileEnc.exists()) {
        await fileEnc.delete();
      }
    }

    if (response.statusCode != 200) {
      throw Exception('Request failed, status=${response.statusCode}');
    }

    return Secret(secretKey, secretHeader);
  }
}
