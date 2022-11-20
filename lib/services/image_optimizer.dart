import 'dart:io';

import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:exif/exif.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:photos/models/metadata.dart';

enum ImageResolution {
  sd(360, 50),
  hd(720, 50),
  qhd(1440, 50);

  final int height;
  final int quality;

  const ImageResolution(this.height, this.quality);

  @override
  String toString() {
    return name;
  }
}

class ImageSize {
  final int width;
  final int height;

  ImageSize(this.width, this.height);
}

class ImageOptimizer {
  final _dateFormat = DateFormat("yyyy:MM:dd hh:mm:ss");
  final _log = Logger('ImageOptimizer');

  ImageOptimizer();

  Future<Metadata> getMetadata(File src) async {
    _log.fine('Extracting embedded metadata, src=${src.path}');

    final fileMetadata = await src.stat();
    final imageMetadata = await readExifFromFile(src, details: false);

    var widthAsTag = imageMetadata['Image ImageWidth'];
    var heightAsTag = imageMetadata['Image ImageLength'];

    int width, height;
    if (widthAsTag != null && heightAsTag != null) {
      width = int.parse(widthAsTag.printable, radix: 10);
      height = int.parse(heightAsTag.printable, radix: 10);
    } else {
      var size = ImageSizeGetter.getSize(FileInput(src));
      width = size.width;
      height = size.height;
      _log.warning(
        'No size in embedded metadata. Fallback to an image size, '
        'src=${src.path} width=${size.width} height=${size.height}',
      );
    }

    int? orientation;

    var orientationAsTag = imageMetadata['Image Orientation'];
    if (orientationAsTag != null) {
      orientation = orientationAsTag.values.firstAsInt();
    } else {
      _log.warning('No orientation in embedded metadata, src=${src.path}');
    }

    DateTime date = fileMetadata.modified;

    var dateAsTag = imageMetadata['Image DateTime'];
    if (dateAsTag != null) {
      var dateAsStr = dateAsTag.printable;
      try {
        date = _dateFormat.parseUtc(dateAsStr);
      } on FormatException {
        _log.warning(
          'Unknown date format in embedded metadata. Fallback to a file date, '
          'src=${src.path} metaDate=$dateAsStr fileDate=$date',
        );
      }
    } else {
      _log.warning(
        'No date in embedded metadata. Fallback to a file date, '
        'src=${src.path} date=$date',
      );
    }

    var result = Metadata(
      width,
      height,
      orientation,
      fileMetadata.size,
      date,
    );

    _log.fine('Created metadata, src=${src.path} metadata=$result');

    return result;
  }

  int _findClosestSample(
    int originalWidth,
    int originalHeight,
    int targetWidth,
    int targetHeight,
  ) {
    double inSampleSize = 2;
    double closestWidth = originalWidth / inSampleSize;
    double closestHeight = originalHeight / inSampleSize;

    while (closestWidth > targetWidth && closestHeight > targetHeight) {
      inSampleSize *= 2;

      closestWidth = originalWidth / inSampleSize;
      closestHeight = originalHeight / inSampleSize;
    }

    return inSampleSize ~/ 2;
  }

  ImageSize _findClosestSize(
    int originalWidth,
    int originalHeight,
    int targetHeight,
  ) {
    double ratio = originalWidth / originalHeight;
    int targetWidth = (ratio * targetHeight).round();

    if (targetWidth > originalWidth || targetHeight > originalHeight) {
      return ImageSize(originalWidth, originalHeight);
    } else {
      return ImageSize(targetWidth, targetHeight);
    }
  }

  Future<void> compress(
    File src,
    File dst,
    Metadata metadata,
    ImageResolution resolution,
  ) async {
    var originalWidth = metadata.width;
    var originalHeight = metadata.height;

    var size = _findClosestSize(
      originalWidth,
      originalHeight,
      resolution.height,
    );

    var inSampleSize = _findClosestSample(
      originalWidth,
      originalHeight,
      size.width,
      size.height,
    );

    var minWidth = !metadata.rotatedToPortrait ? size.width : size.height;
    var minHeight = !metadata.rotatedToPortrait ? size.height : size.width;

    _log.fine(
      'Compressing image, '
      'src=${src.path} dst=${dst.path} '
      'minWidth=$minWidth minHeight=$minHeight '
      'inSampleSize=$inSampleSize quality=${resolution.quality}',
    );

    var result = await FlutterImageCompress.compressAndGetFile(
      src.absolute.path,
      dst.absolute.path,
      minWidth: minWidth,
      minHeight: minHeight,
      format: CompressFormat.jpeg,
      inSampleSize: inSampleSize,
      quality: resolution.quality,
      keepExif: false,
    );

    if (result == null) {
      throw Exception('Compress failed');
    }
  }
}
