class Metadata {
  // ignore: todo
  // TODO store exif as original bytes

  int width;
  int height;

  // Quick summary:
  // https://jdhao.github.io/2019/07/31/image_rotation_exif_info/
  int? orientation; // 1-9 values
  int fileSize; // bytes
  DateTime date;

  Metadata(
    this.width,
    this.height,
    this.orientation,
    this.fileSize,
    this.date,
  );

  bool get rotatedToPortrait {
    return [8, 6].contains(orientation);
  }

  int get fileSizeInMB {
    return fileSize ~/ 1000000;
  }

  @override
  String toString() {
    return 'width=$width height=$height '
        'orientation=$orientation fileSize=$fileSize '
        'date=$date';
  }
}
