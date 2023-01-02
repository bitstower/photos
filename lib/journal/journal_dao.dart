import 'package:meta/meta.dart';
import 'package:photos/journal/journal_repository.dart';
import 'package:photos/journal/record_serializer.dart';

import 'record.dart';

@sealed
class JournalDao {
  final JournalRepository _repository;
  final RecordSerializer _serializer;

  JournalDao(this._repository, this._serializer);

  Future<List<Record>> getUnreadRecords() async {
    final records = <Record>[];

    final journals = await _repository.getUnreadJournals();
    for (var journal in journals) {
      var objects = await journal.read();
      for (var object in objects) {
        records.add(_serializer.fromJson(object));
      }
    }

    return records;
  }

  Future addRecord(Record record) async {
    final journal = await _repository.getOwnJournal();
    await journal.append(_serializer.toJson(record));
  }
}
