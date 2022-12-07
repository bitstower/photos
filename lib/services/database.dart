import 'package:isar/isar.dart';
import '../models/media.dart';

class Database {
  Isar? _instance;

  Isar open() {
    return _instance ??= Isar.openSync([MediaSchema]);
  }

  Future<void> close() async {
    await _instance?.close();
    _instance = null;
  }
}
