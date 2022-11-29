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

  final _log = Logger('Journal');

  Journal(this.file);

  Future<int> append(List<dynamic> events) async {
    var writer = await file.open(mode: FileMode.write);

    // go to the start and update event count
    await writer.setPosition(0);
    var countAsBytes = await writer.read(kUint32Size);
    await writer.writeFrom(incrementUint32(countAsBytes, events.length));

    // go to the end and append events
    await writer.setPosition(await writer.length());
    for (var event in events) {
      await _writeEvent(writer, event);
    }

    await writer.flush();
    await writer.close();

    var fileSize = await file.length(); // bytes

    _log.fine(
      'Appended ${events.length} events, '
      'file=${file.path} fileSize=$fileSize',
    );

    return fileSize;
  }

  Future<int> count() async {
    var reader = await file.open(mode: FileMode.read);

    // go to the start and read event count
    await reader.setPosition(0);
    var countAsBytes = await reader.read(kUint32Size);

    await reader.close();

    return fromUint32(countAsBytes);
  }

  Future<List<dynamic>> readAll() async {
    return read(kUint32Size); // skip event count at the start
  }

  Future<List<dynamic>> read(int offset) async {
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
