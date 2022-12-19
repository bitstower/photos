import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

@sealed
class TmpDir {
  const TmpDir();

  Future<File> getFile(String name, String extension) async {
    final tempDir = await getTemporaryDirectory();
    return File('${tempDir.path}/$name.$extension');
  }
}
