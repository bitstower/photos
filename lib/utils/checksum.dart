import 'dart:io';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:meta/meta.dart';

@sealed
class Checksum {
  const Checksum();

  Future<String> generateHash(File file) async {
    final stream = file.openRead();
    final hash = await md5.bind(stream).first;
    return base64.encode(hash.bytes);
  }
}
