import 'image_size.dart';

enum ImageResolution {
  sd(360, 50),
  hd(720, 50),
  qhd(1440, 50);

  final int height;
  final int quality;

  const ImageResolution(this.height, this.quality);

  ImageSize findClosestSize(
    ImageSize orientatedSize,
  ) {
    var size = orientatedSize;

    // change to landscape if needed
    var flipped = false;
    if (size.isPortrait) {
      size = size.flip();
      flipped = true;
    }

    int targetWidth = (size.ratio * height).round();

    // prevent upscaling
    if (size.width > targetWidth && size.height > height) {
      size = ImageSize(targetWidth, height);
    }

    // change back to portrait if needed
    if (flipped) {
      size = size.flip();
    }

    return size;
  }

  @override
  String toString() {
    return name;
  }
}
