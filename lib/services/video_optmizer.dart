import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoOptimizer {
  static const int maxBitrate = 2000000; // 2 MB/s

  final log = Logger('VideoOptimizer');

  Uuid uuid;

  VideoOptimizer(this.uuid);

  Future<File> extractFrame(File src) async {
    var tempDir = await getTemporaryDirectory();
    var dstPath = '${tempDir.absolute.path}/${uuid.v4()}.jpg';

    await VideoThumbnail.thumbnailFile(
      video: src.absolute.path,
      thumbnailPath: dstPath,
      imageFormat: ImageFormat.JPEG,
      quality: 100,
    );

    return File(dstPath);
  }

  Future<MediaInfo> getMediaInfo(File src) async {
    return await VideoCompress.getMediaInfo(
      src.absolute.path,
    );
  }

  Future<bool> shouldCompress(File src, MediaInfo mediaInfo) async {
    if (!src.path.endsWith('.mp4')) {
      log.info('Incompatible container, path=${src.path}, shouldCompress=true');
      return true;
    }

    // TODO if not incompatible video/audio codes then return true

    if (mediaInfo.duration == null || mediaInfo.filesize == null) {
      log.info('Unknown bitrate, path=${src.path}, shouldCompress=true');
      return true;
    }

    int seconds = mediaInfo.duration! ~/ 1000;
    int bitrate = mediaInfo.filesize! ~/ seconds;

    if (bitrate > maxBitrate) {
      log.info('Bitrate out of range, path=${src.path}, shouldCompress=true');
      return true;
    } else {
      log.info('Bitrate in range, path=${src.path}, shouldCompress=false');
      return false;
    }
  }

  VideoQuality _matchQuality(int? width, int? height) {
    if (width == null || height == null) {
      return VideoQuality.HighestQuality;
    }

    if (width >= 1920 && height >= 1080) {
      return VideoQuality.Res1920x1080Quality;
    } else if (width >= 1280 && height >= 720) {
      return VideoQuality.Res1280x720Quality;
    } else if (width >= 960 && height >= 540) {
      return VideoQuality.Res960x540Quality;
    } else {
      return VideoQuality.Res640x480Quality;
    }
  }

  Future<File?> compressVideo(File src, MediaInfo mediaInfo) async {
    MediaInfo? results = await VideoCompress.compressVideo(
      src.absolute.path,
      quality: _matchQuality(mediaInfo.width, mediaInfo.height),
      deleteOrigin: false,
    );

    if (results == null) {
      return null;
    } else {
      return results.file;
    }
  }
}
