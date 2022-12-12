import 'package:isar/isar.dart';
import 'package:photos/models/jar.dart';
import '../models/media.dart';

class Database {
  Isar? _instance;

  Isar open() {
    return _instance ??= Isar.openSync([MediaSchema, JarSchema]);
  }

  Future<void> close() async {
    await _instance?.close();
    _instance = null;
  }
}
