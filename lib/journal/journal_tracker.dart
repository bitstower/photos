import 'dart:io';

class JournalTracker {
  final String uuid;

  final int remoteFileSize;
  final int readOffset;
  final bool own;

  final Directory directory;

  JournalTracker(
    this.uuid,
    this.readOffset, {
    required this.own,
    required this.directory,
    this.remoteFileSize = 0,
  });

  bool get outdated => remoteFileSize != file.lengthSync();
  bool get unread => readOffset < file.lengthSync();
  File get file => File('${directory.path}/$uuid');
  String get uri => '/journal/$uuid';
}
