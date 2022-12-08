import 'package:isar/isar.dart';
import 'package:logging/logging.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/media.dart';
import 'camera_roll.dart';
import 'database.dart';

class LocalMediaReplicator {
  static const String kMinCreateDateSecondKey =
      'localMediaReplicator.minCreateDateSecond';

  final log = Logger('LocalMediaReplicator');

  final Database database;
  final CameraRoll cameraRoll;
  final SharedPreferences options;

  LocalMediaReplicator(this.database, this.cameraRoll, this.options);

  Future<Media?> findDuplicate(AssetEntity entity) async {
    assert(entity.createDateSecond != null);

    var hash = entity.createDateSecond!;

    var connection = database.open();

    var candidates = await connection.medias
        .where()
        .hashEqualTo(
          hash,
        )
        .findAll();

    if (candidates.isEmpty) {
      return null;
    }

    Media? found = candidates.firstWhereOrNull(
      (c) => c.localOrigin?.localId == entity.id,
    );

    if (found != null) {
      return found;
    }

    candidates.removeWhere((c) => c.localOrigin != null);

    if (candidates.isEmpty) {
      return null;
    }

    // TODO compare file size
    // TODO compare checksums
    throw Exception('Not implemented');
  }

  bool validate(AssetEntity entity) {
    if (entity.createDateSecond == null) {
      log.warning('createDateSecond can\'t be null, id=${entity.id}');
      return false;
    }

    return true;
  }

  Future<PermissionState> requestPermission() async {
    return await PhotoManager.requestPermissionExtend();
  }

  Future<bool> isNotAuthorized() async {
    return !(await requestPermission()).hasAccess;
  }

  Future replicate() async {
    if (await isNotAuthorized()) {
      return;
    }

    var connection = database.open();

    AssetEntity? first;
    AssetPage? page = await cameraRoll.getPage(minCreateDateSecond);

    while (page != null) {
      var entities = await page.getEntities();

      for (var entity in entities) {
        if (validate(entity)) {
          first ??= entity;
          await connection.writeTxn(() async {
            var duplicate = await findDuplicate(entity);
            if (duplicate == null) {
              await connection.medias.put(Media.fromLocalMediaStore(entity));
            } else {
              duplicate.localOrigin = LocalAsset.fromLocalMediaStore(entity);
              await connection.medias.put(duplicate);
            }
          });
        }
      }

      page = page.getNextPage();
    }

    if (first != null) {
      minCreateDateSecond = first.createDateSecond!;
    }
  }

  int get minCreateDateSecond {
    return options.getInt(kMinCreateDateSecondKey) ?? 0;
  }

  set minCreateDateSecond(int value) {
    options.setInt(kMinCreateDateSecondKey, value);
  }
}
