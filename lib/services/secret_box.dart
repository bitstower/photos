import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_sodium/flutter_sodium.dart';

class SecretBox {
  static const int encryptionChunkSize = 4 * 1024 * 1024;

  const SecretBox();

  Uint8List generateKey() {
    return Sodium.cryptoSecretstreamXchacha20poly1305Keygen();
  }

  Future<Uint8List> encrypt(
    File src,
    File dst,
    Uint8List key,
  ) async {
    final sourceFile = src;
    final destinationFile = dst;

    if (await dst.exists()) {
      await dst.delete();
    }

    final sourceFileLength = await sourceFile.length();
    final inputFile = sourceFile.openSync(mode: FileMode.read);
    final initPushResult =
        Sodium.cryptoSecretstreamXchacha20poly1305InitPush(key);
    var bytesRead = 0;
    var tag = Sodium.cryptoSecretstreamXchacha20poly1305TagMessage;
    while (tag != Sodium.cryptoSecretstreamXchacha20poly1305TagFinal) {
      var chunkSize = encryptionChunkSize;
      if (bytesRead + chunkSize >= sourceFileLength) {
        chunkSize = sourceFileLength - bytesRead;
        tag = Sodium.cryptoSecretstreamXchacha20poly1305TagFinal;
      }
      final buffer = inputFile.readSync(chunkSize);
      bytesRead += chunkSize;
      final encryptedData = Sodium.cryptoSecretstreamXchacha20poly1305Push(
        initPushResult.state,
        buffer,
        null,
        tag,
      );
      await destinationFile.writeAsBytes(encryptedData, mode: FileMode.append);
    }
    inputFile.closeSync();

    return initPushResult.header;
  }
}
