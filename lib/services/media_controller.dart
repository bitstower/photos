import 'package:isar/isar.dart';
import 'package:photo_manager/photo_manager.dart';

import '../models/media.dart';
import 'database.dart';

class MediaController {
  final Database database;

  MediaController(this.database);

  Future<List<int>> getIds() async {
    var connection = database.open();
    return await connection.medias
        .where()
        .sortByTakenDesc()
        .idProperty()
        .findAll();
  }

  List<int> getIdsSync() {
    var connection = database.open();
    return connection.medias
        .where()
        .sortByTakenDesc()
        .idProperty()
        .findAllSync();
  }

  Future<Media?> getById(int id) async {
    var connection = database.open();
    return await connection.medias.get(id);
  }

  Future<AssetEntity?> getLocalAsset(int id) async {
    var media = await getById(id);
    var localId = media?.localOrigin?.localId;
    return localId != null ? await AssetEntity.fromId(localId) : null;
  }
}
