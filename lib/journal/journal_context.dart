import 'package:photos/utils/serializer.dart';

class JournalContext {
  final Map<String, int> readOffsets;

  JournalContext({required this.readOffsets});

  int getReadOffset(String uuid) => readOffsets[uuid] ?? 0;
  setReadOffset(String uuid, int val) => readOffsets[uuid] = val;
}

class JournalContextSerializer extends Serializer<JournalContext> {
  final _readOfssets = 'readOffsets';

  @override
  JournalContext fromJson(Map json) {
    var readOffsets = json[_readOfssets] as Map<String, int>?;
    return JournalContext(
      readOffsets: readOffsets ?? {},
    );
  }

  @override
  Map toJson(JournalContext src) {
    var json = <String, dynamic>{};
    json[_readOfssets] = src.readOffsets;
    return Map.unmodifiable(json);
  }
}
