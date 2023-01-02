import 'package:photos/journal/journal.dart';

class WriteJournal extends Journal {
  WriteJournal(super.file, super.offset);

  @override
  Future<List<dynamic>> read() {
    throw UnimplementedError();
  }
}
