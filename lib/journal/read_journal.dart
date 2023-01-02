import 'package:photos/journal/journal.dart';

class ReadJournal extends Journal {
  ReadJournal(super.file, super.offset);

  @override
  Future<int> append(List<dynamic> records) {
    throw UnimplementedError();
  }
}
