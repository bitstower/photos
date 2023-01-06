import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sodium/flutter_sodium.dart';
import '../utils/bytes.dart';

// https://doc.libsodium.org/secret-key_cryptography/secretstream
class SecretStream {
  static const int maxChunkSize = 4 * 1024 * 1024; // 4 MB

  Uint8List generateSecretKey() {
    return Sodium.cryptoSecretstreamXchacha20poly1305Keygen();
  }

  Stream<List<int>> encrypt(
    Stream<List<int>> stream,
    int contentLength,
    Uint8List secretKey,
  ) async* {
    final chunkedReader = ChunkedStreamReader(stream);

    try {
      final chunkedStream = chunkedReader.readStream(maxChunkSize);

      final pushResult = Sodium.cryptoSecretstreamXchacha20poly1305InitPush(
        secretKey,
      );

      yield pushResult.header;

      var offset = 0;
      await for (final chunkAsInts in chunkedStream) {
        final chunkAsBytes = toUint8List(chunkAsInts);
        final chunkSize = chunkAsBytes.lengthInBytes;
        final tag = offset + chunkSize >= contentLength
            ? Sodium.cryptoSecretstreamXchacha20poly1305TagFinal
            : Sodium.cryptoSecretstreamXchacha20poly1305TagMessage;
        yield Sodium.cryptoSecretstreamXchacha20poly1305Push(
          pushResult.state,
          chunkAsBytes,
          null,
          tag,
        );
        offset += chunkSize;
      }
    } finally {
      await chunkedReader.cancel();
    }
  }

  Stream<List<int>> decrypt(
    Stream<List<int>> stream,
    int contentLength,
    Uint8List secretKey,
  ) async* {
    final chunkedReader = ChunkedStreamReader(stream);

    try {
      final headerSize = Sodium.cryptoSecretstreamXchacha20poly1305Headerbytes;
      final headerAsInts = await chunkedReader.readChunk(headerSize);
      final headerAsBytes = toUint8List(headerAsInts);

      final pullState = Sodium.cryptoSecretstreamXchacha20poly1305InitPull(
        headerAsBytes,
        secretKey,
      );

      final maxEncChunkSize =
          maxChunkSize + Sodium.cryptoSecretstreamXchacha20poly1305Abytes;
      final chunkedStream = chunkedReader.readStream(maxEncChunkSize);

      await for (final chunkAsInts in chunkedStream) {
        final chunkAsBytes = toUint8List(chunkAsInts);
        final result = Sodium.cryptoSecretstreamXchacha20poly1305Pull(
          pullState,
          chunkAsBytes,
          null,
        );
        yield result.m;
      }
    } finally {
      await chunkedReader.cancel();
    }
  }
}
