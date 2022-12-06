import 'package:isar/isar.dart';
import '../models/media.dart';

class Database {
  Isar? _instance;

  Future<Isar> open() async {
    return _instance ??= await Isar.open([MediaSchema]);
  }

  Future<void> close() async {
    await _instance?.close();
    _instance = null;
  }
}
