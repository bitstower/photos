import '../utils/context.dart';

class JournalContext extends Context {
  JournalContext(super.jarId, super.jarDao);

  int getReadOffset(String uuid) => getValue(uuid) ?? 0;
  Future setReadOffset(String uuid, int value) => setValue(uuid, value);
}
