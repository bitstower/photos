import 'package:meta/meta.dart';
import 'package:photos/journal/journal_repository.dart';

import 'record.dart';

@sealed
class JournalDao {
  final JournalRepository _repository;

  JournalDao(this._repository);

  Future<List<Record>> getUnreadRecords() async {
    final records = <Record>[];

    final journals = await _repository.getUnreadJournals();
    for (var journal in journals) {
      var objects = await journal.read();
      for (var object in objects) {
        records.add(Record.fromMap(object));
      }
    }

    return records;
  }

  Future addRecord(Record record) async {
    final journal = await _repository.getOwnJournal();
    journal.append([record.asMap()]);
  }
}
