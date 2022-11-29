import 'dart:typed_data';

const int kUint32Size = 4;

int fromUint32(Uint8List bytes) {
  if (bytes.lengthInBytes == 0) {
    return 0;
  }

  assert(bytes.lengthInBytes == kUint32Size);
  return ByteData.view(bytes.buffer).getUint32(0);
}

Uint8List toUint32(int value) {
  var bytes = Uint8List(kUint32Size);
  ByteData.view(bytes.buffer).setUint32(0, value);
  return bytes;
}

Uint8List incrementUint32(Uint8List bytes, int step) {
  return toUint32(fromUint32(bytes) + step);
}
