// ignore_for_file: unnecessary_null_comparison

import 'package:meta/meta.dart';
import 'package:photos/services/database.dart';

import '../models/jar.dart';

@sealed
class JarDao {
  final Database database;

  JarDao(this.database);

  Future<Jar?> getById(int id) async {
    var connection = database.open();
    return await connection.jars.get(id);
  }

  Future put(Jar jar) async {
    assert(jar.id != null);
    assert(jar.payload != null);
    var connection = database.open();
    await connection.writeTxn(() async {
      await connection.jars.put(jar);
    });
  }
}
