import 'package:photos/models/media.dart';

import 'database.dart';

class MediaDao {
  final Database _database;

  MediaDao(this._database);

  Future<Media?> getById(int id) async {
    var conn = _database.open();
    return conn.medias.get(id);
  }

  Future put(Media media) async {
    var conn = _database.open();
    await conn.writeTxn(() async {
      await conn.medias.put(media);
    });
  }
}
