import 'dart:io';

import 'package:logging/logging.dart';
import 'package:msgpack_dart/msgpack_dart.dart';

import '../utils/bytes.dart';

/// Journal structure:
///
///    event_count (4)
///    event_size (4)
///    event (n)
///    ...
///    event_size (4)
///    event (n)
///
class Journal {
  final File file;
  final int offset;

  final _log = Logger('Journal');

  Journal(this.file, this.offset);

  Future append(dynamic record) async {
    var writer = await file.open(mode: FileMode.append);

    await _writeEvent(writer, record);

    await writer.flush();
    await writer.close();

    var fileSize = await file.length(); // bytes

    _log.fine('Appended a record, file=${file.path} fileSize=$fileSize');
  }

  Future<List<dynamic>> read() async {
    var fileSize = await file.length();
    if (fileSize == 0) {
      return [];
    }

    List<dynamic> events = [];

    var reader = await file.open(mode: FileMode.read);
    await reader.setPosition(offset);

    var event = await _readEvent(reader);
    while (event != null) {
      events.add(event);
      event = await _readEvent(reader);
    }

    await reader.close();

    return events;
  }

  Future _writeEvent(RandomAccessFile writer, dynamic event) async {
    var eventAsBytes = serialize(event);
    await writer.writeFrom(toUint32(eventAsBytes.lengthInBytes));
    await writer.writeFrom(eventAsBytes);
  }

  Future<dynamic> _readEvent(RandomAccessFile reader) async {
    var sizeAsBytes = await reader.read(kUint32Size);
    if (sizeAsBytes.lengthInBytes != kUint32Size) {
      return null;
    }

    var size = fromUint32(sizeAsBytes);
    var eventAsBytes = await reader.read(size);
    var event = deserialize(eventAsBytes);

    return event;
  }
}

class ReadJournal extends Journal {
  ReadJournal(super.file, super.offset);

  @override
  Future<int> append(dynamic record) {
    throw UnimplementedError();
  }
}

class WriteJournal extends Journal {
  WriteJournal(super.file, super.offset);

  @override
  Future<List<dynamic>> read() {
    throw UnimplementedError();
  }
}
