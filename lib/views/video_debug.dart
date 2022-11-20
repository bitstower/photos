import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:photos/services/video_optmizer.dart';
import 'package:uuid/uuid.dart';

import '../utils/ui.dart';

class VideoDebugPage extends StatefulWidget {
  const VideoDebugPage({super.key});

  @override
  State<VideoDebugPage> createState() => _VideoDebugPageState();
}

class _VideoDebugPageState extends State<VideoDebugPage> {
  final log = Logger('VideoDebug');
  final _videoOptimizer = VideoOptimizer(Uuid(), FlutterVideoInfo());

  int _fileSize = 0;
  int _videoHeight = 0;
  int _videoWidth = 0;
  int? _videoOrientation;
  int? _videoDurationSec;

  Future<void> inspect() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowCompression: false,
      type: FileType.custom,
      allowedExtensions: ['mp4'],
    );

    if (result != null) {
      var src = File(result.files.single.path!);

      Stopwatch s = Stopwatch();
      s.start();

      var frame = await _videoOptimizer.extractFrame(src);

      s.stop();

      log.info('Extract frame done, time=${s.elapsedMilliseconds} ms');
      frame.copySync('/storage/emulated/0/Download/vid-thumbnail.jpg');

      var metadata = await _videoOptimizer.getMetadata(src, frame);

      setState(() {
        _fileSize = metadata.fileSizeInMB;
        _videoHeight = metadata.height;
        _videoWidth = metadata.width;
        _videoDurationSec = metadata.durationInSec;
        _videoOrientation = metadata.orientation;
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
                  inspect();
                },
              ),
            ]),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('original size: ${_fileSize.toString()} MB'),
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
