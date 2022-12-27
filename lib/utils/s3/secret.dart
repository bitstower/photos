import 'package:flutter/foundation.dart';

class Secret {
  final Uint8List key;
  final Uint8List header;

  const Secret(this.key, this.header);
}
