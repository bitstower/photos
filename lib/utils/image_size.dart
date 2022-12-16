import 'package:meta/meta.dart';

@sealed
class ImageSize {
  final int width;
  final int height;

  const ImageSize(this.width, this.height);

  double get ratio => width / height;

  bool get isPortrait => height > width;

  ImageSize flip() => ImageSize(height, width);
}
