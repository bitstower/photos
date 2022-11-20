import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../models/metadata.dart';
import '../services/image_optimizer.dart';
import '../utils/ui.dart';

class CompressResult {
  final File file;
  final int width;
  final int height;

  CompressResult(this.file, this.width, this.height);

  get path {
    return file.absolute.path;
  }
}

class ImageDebugPage extends StatefulWidget {
  const ImageDebugPage({super.key});

  @override
  State<ImageDebugPage> createState() => _ImageDebugPageState();
}

class _ImageDebugPageState extends State<ImageDebugPage> {
  final ImageOptimizer _imageOptimizer = ImageOptimizer();

  File? _original;
  File? _sdImage;
  File? _hdImage;
  File? _qhdImage;

  Future<File> compressImage(
    File src,
    Metadata metadata,
    ImageResolution resolution,
  ) async {
    var name = resolution.toString();
    var path = '/storage/emulated/0/Download/img-$name.jpg';
    _imageOptimizer.compress(
      src,
      File(path),
      metadata,
      resolution,
    );

    return File(path);
  }

  Future<void> createVariants() async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    final file = File(xFile!.path);

    var metadata = await _imageOptimizer.getMetadata(file);

    var sdImage = await compressImage(
      file,
      metadata,
      ImageResolution.sd,
    );
    var hdImage = await compressImage(
      file,
      metadata,
      ImageResolution.hd,
    );
    var qhdImage = await compressImage(
      file,
      metadata,
      ImageResolution.qhd,
    );

    setState(() {
      imageCache.clear();
      imageCache.clearLiveImages();
      _original = file;
      _sdImage = sdImage;
      _hdImage = hdImage;
      _qhdImage = qhdImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Ui.darkNavigationBar(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: const Text('Image Debug'),
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
                  await createVariants();
                },
              ),
            ]),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_sdImage != null) ...[
                  const Text('sd:'),
                  Image.file(
                    _sdImage!,
                    key: UniqueKey(),
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                    isAntiAlias: true,
                  ),
                ],
                if (_hdImage != null) ...[
                  const Text('hd:'),
                  Image.file(
                    _hdImage!,
                    key: UniqueKey(),
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                    isAntiAlias: true,
                  ),
                ],
                if (_qhdImage != null) ...[
                  const Text('qhd:'),
                  Image.file(
                    _qhdImage!,
                    key: UniqueKey(),
                    fit: BoxFit.cover,
                    isAntiAlias: true,
                  ),
                ],
                if (_original != null) ...[
                  const Text('original:'),
                  Image.file(
                    _original!,
                    key: UniqueKey(),
                    fit: BoxFit.cover,
                    isAntiAlias: true,
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
