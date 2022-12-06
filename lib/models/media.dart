import 'package:isar/isar.dart';
import 'package:photo_manager/photo_manager.dart';

part 'media.g.dart';

// TODO fileSize: add
// MediaStore can return file size as metadata
// Modify photo_manager accordingly.

// TODO hash: reimplement
// Replace taken with fileSize

@collection
class Media {
  Id id = Isar.autoIncrement;

  @Index()
  late int taken; // not null, seconds

  @Index()
  int get hash => taken;

  @Enumerated(EnumType.value, 'value')
  late MediaType type;

  late short orientatedWidth;

  late short orientatedHeight;

  late short orientation;

  late short duration; // seconds

  LocalAsset? localOrigin;
  RemoteAsset? remoteOrigin;

  // final remoteSdThumbnail = IsarLink<RemoteAsset>();
  // final remoteQhdThumbnail = IsarLink<RemoteAsset>();

  static Media fromLocalMediaStore(AssetEntity entity) {
    assert(entity.createDateSecond != null);
    return Media()
      ..type = MediaType.fromLocalMediaStore(entity)
      ..taken = entity.createDateSecond!
      ..orientatedWidth = entity.orientatedWidth
      ..orientatedHeight = entity.orientatedHeight
      ..orientation = entity.orientation
      ..duration = entity.duration
      ..localOrigin = LocalAsset.fromLocalMediaStore(entity);
  }
}

@embedded
class LocalAsset {
  late String localId;

  // String? fileType; // mime type
  // int? fileSize; // bytes

  static LocalAsset fromLocalMediaStore(AssetEntity entity) {
    return LocalAsset()..localId = entity.id;
  }
}

@embedded
class RemoteAsset {
  late String uuid; // v4
  late List<byte> secret; // aes
  late List<byte> checksum; // md5
  late String fileType; // mime type
  late int fileSize; // bytes
}

enum MediaType {
  image(0),
  video(1);

  const MediaType(this.value);

  final byte value;

  static MediaType fromLocalMediaStore(AssetEntity entity) {
    switch (entity.type) {
      case AssetType.image:
        return MediaType.image;
      case AssetType.video:
        return MediaType.video;
      default:
        throw Exception('Unknown type');
    }
  }
}
