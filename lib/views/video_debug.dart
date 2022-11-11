import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:photos/services/video_optmizer.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../utils/ui.dart';

class VideoDebugPage extends StatefulWidget {
  const VideoDebugPage({super.key});

  @override
  State<VideoDebugPage> createState() => _VideoDebugPageState();
}

class _VideoDebugPageState extends State<VideoDebugPage> {
  final _videoOptimizer = VideoOptimizer(Uuid());

  int _transcodeTimeSec = 0;
  int _videoSize = 0;
  int _videoHeight = 0;
  int _videoWidth = 0;
  int _videoOrientation = 0;
  int _videoDurationSec = 0;

  Future<void> transcode() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowCompression: false,
      type: FileType.custom,
      allowedExtensions: ['mp4'],
    );

    if (result != null) {
      var src = File(result.files.single.path!);
      MediaInfo mediaInfo1 = await _videoOptimizer.getMediaInfo(src);

      setState(() {
        _videoSize = mediaInfo1.filesize! ~/ 1000000; // MB
        _videoHeight = mediaInfo1.height!;
        _videoWidth = mediaInfo1.width!;
        _videoDurationSec = mediaInfo1.duration! ~/ 1000; // seconds
        _videoOrientation = mediaInfo1.orientation!;
      });

      var frame = await _videoOptimizer.extractFrame(src);
      frame.copySync('/storage/emulated/0/Download/vid-thumbnail.jpg');

      Stopwatch s = new Stopwatch();
      s.start();

      var video = await _videoOptimizer.compressVideo(src, mediaInfo1);

      s.stop();

      video!.copySync('/storage/emulated/0/Download/vid.mp4');
      // await VideoCompress.deleteAllCache();

      setState(() {
        _transcodeTimeSec = s.elapsedMilliseconds ~/ 1000; // seconds
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Ui.darkNavigationBar(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: const Text('Video Debug'),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              tooltip: 'Back',
              onPressed: () => GoRouter.of(context).pop(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.file_open_rounded),
                tooltip: 'Open file',
                onPressed: () async {
                  transcode();
                },
              ),
            ]),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('transcode time: ${_transcodeTimeSec.toString()} s'),
                Text('original size: ${_videoSize.toString()} MB'),
                Text('height: ${_videoHeight.toString()}'),
                Text('width: ${_videoWidth.toString()}'),
                Text('orientation: ${_videoOrientation.toString()}'),
                Text('duration: ${_videoDurationSec.toString()} s'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
