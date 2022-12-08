import 'dart:io';

import 'package:photo_manager/photo_manager.dart';
import 'package:photos/services/database.dart';

class LocalMediaStorage {
  Future<File?> getOrigin(String localId) async {
    var asset = await AssetEntity.fromId(localId);
    return await asset?.originFile;
  }

  Future<File?> getThumbnail(
    String localId,
  ) async {
    return null;
  }
}
