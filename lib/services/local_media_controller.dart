import 'package:isar/isar.dart';
import 'package:photos/services/media_controller.dart';

import '../models/media.dart';
import 'database.dart';

class LocalMediaController extends MediaController {
  final Database database;

  LocalMediaController(this.database);

  @override
  Future<Media> getMedia(index) async {
    var connection = await database.open();
    var results = await connection.medias
        .where()
        .sortByTakenDesc()
        .offset(index)
        .limit(1)
        .findAll();
    return results.single;
  }

  @override
  Future<int> getCount() async {
    var connection = await database.open();
    return await connection.medias.count();
  }
}
