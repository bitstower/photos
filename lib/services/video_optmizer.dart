import 'dart:io';

import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import '../models/video_metadata.dart';

class VideoOptimizer {
  final _log = Logger('VideoOptimizer');

  final Uuid _uuid;
  final FlutterVideoInfo _pluginVideoInfo;

  VideoOptimizer(this._uuid, this._pluginVideoInfo);

  Future<File> extractFrame(File src) async {
    var tempDir = await getTemporaryDirectory();
    var dstPath = '${tempDir.absolute.path}/${_uuid.v4()}.jpg';

    _log.fine('Extracting video frame, src=${src.path} dst=$dstPath');

    await VideoThumbnail.thumbnailFile(
      video: src.absolute.path,
      thumbnailPath: dstPath,
      imageFormat: ImageFormat.JPEG,
      quality: 100,
    );

    return File(dstPath);
  }

  Future<VideoMetadata> getMetadata(File src, File frame) async {
    _log.fine('Extracting embedded metadata, src=${src.path}');

    var fileMetadata = await src.stat();
    var videoMetadata = await _pluginVideoInfo.getVideoInfo(src.absolute.path);

    if (videoMetadata == null) {
      throw Exception('File doesn\'t exist');
    }

    var width = videoMetadata.width;
    var height = videoMetadata.height;
    if (width == null || height == null) {
      var size = ImageSizeGetter.getSize(FileInput(src));

      _log.warning(
        'No size in embedded metadata. Fallback to a frame size, '
        'src=${src.path} width=${size.width} height=${size.height}',
      );

      width = size.width;
      height = size.height;
    }

    int? orientation;

    switch (videoMetadata.orientation) {
      case 0:
        orientation = 1;
        break;
      case 90:
        orientation = 6;
        break;
      case 180:
        orientation = 3;
        break;
      case 270:
        orientation = 8;
        break;
      default:
        _log.warning(
          'Unknown orientation in embedded metadata, '
          'src=${src.path} orientation=${videoMetadata.orientation}',
        );
        break;
    }

    DateTime date = fileMetadata.modified;

    var dateAsStr = videoMetadata.date;
    if (dateAsStr != null) {
      try {
        date = DateTime.parse(dateAsStr);
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

    double? duration = videoMetadata.duration;
    if (duration == null) {
      _log.warning('No duration in embedded metadata, src=${src.path}');
    }

    var result = VideoMetadata(
      width,
      height,
      orientation,
      fileMetadata.size,
      date,
      duration,
    );

    _log.fine('Created metadata. src=${src.path} metadata=$result');

    return result;
  }
}
