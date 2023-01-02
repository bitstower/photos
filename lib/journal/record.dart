import 'record_type.dart';

class Record {
  final _type = 0;
  final _timestamp = 1;
  final _schema = 2;

  final Map<int, dynamic> properties;

  Record({required RecordType type}) : properties = {} {
    properties[_type] = type.idx;
    properties[_timestamp] = DateTime.now().millisecondsSinceEpoch;
    properties[_schema] = 1;
  }

  Record.fromMap(this.properties) {
    assert(properties[_type] != null);
    assert(properties[_schema] != null);
    assert(properties[_timestamp] != null);
  }

  Map<int, dynamic> asMap() {
    return Map.unmodifiable(properties);
  }

  RecordType getType() => RecordType.fromNum(properties[_type]);
  int getTimestamp() => properties[_timestamp];
  int getSchema() => properties[_schema];
}
