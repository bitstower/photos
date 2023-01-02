import 'package:flutter/foundation.dart';

class Record {
  final RecordType type;
  final dynamic payload;

  final int timestamp;
  final int schema;

  Record({
    required this.type,
    required this.payload,
    int? timestamp,
    int? schema,
  })  : timestamp = timestamp ?? DateTime.now().millisecondsSinceEpoch,
        schema = schema ?? 1;
}

enum RecordType {
  postMedia(0);

  final int idx;

  const RecordType(this.idx);

  static RecordType fromNum(int idx) {
    switch (idx) {
      case 0:
        return postMedia;
      default:
        throw Exception('Unknown value');
    }
  }
}

class PostMedia {
  final int type;
  final int taken;
  final int orientatedWidth;
  final int orientatedHeight;
  final int orientation;
  final int duration;

  final Asset smThumbAsset;
  final Asset mdThumbAsset;
  final Asset lgThumbAsset;
  final Asset originAsset;

  PostMedia({
    required this.type,
    required this.taken,
    required this.orientatedWidth,
    required this.orientatedHeight,
    required this.orientation,
    required this.duration,
    required this.smThumbAsset,
    required this.mdThumbAsset,
    required this.lgThumbAsset,
    required this.originAsset,
  });
}

class Asset {
  final String uuid;
  final Uint8List secretKey;
  final Uint8List secretHeader;
  final String checksum;
  final int fileSize;
  final String fileType;

  Asset({
    required this.uuid,
    required this.secretKey,
    required this.secretHeader,
    required this.checksum,
    required this.fileSize,
    required this.fileType,
  });
}
