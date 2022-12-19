// ignore_for_file: unnecessary_null_comparison

import 'package:meta/meta.dart';
import 'package:photos/services/database.dart';

import '../models/jar.dart';

@sealed
class JarDao {
  final Database _database;

  JarDao(this._database);

  Future<Jar?> getById(int id) async {
    var conn = _database.open();
    return await conn.jars.get(id);
  }

  Future put(Jar jar) async {
    assert(jar.id != null);
    assert(jar.payload != null);
    var conn = _database.open();
    await conn.writeTxn(() async {
      await conn.jars.put(jar);
    });
  }
}
