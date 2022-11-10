import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../utils/ui.dart';
import 'package:exif/exif.dart';

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
  File? _original;
  CompressResult? _smallVariantResult;
  CompressResult? _mediumVariantResult;
  CompressResult? _largeVariantResult;

  Future<CompressResult> compressImage(File file, int width, int height,
      int inSampleSize, int quality, bool isPortrait) async {
    var minWidth = isPortrait ? height : width;
    var minHeight = isPortrait ? width : height;

    var outputFile = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      '/storage/emulated/0/Download/img-${width}x${height}.jpg',
      minWidth: minWidth,
      minHeight: minHeight,
      format: CompressFormat.jpeg,
      inSampleSize: inSampleSize,
      quality: quality,
      keepExif: false,
    );

    return CompressResult(outputFile!, width, height);
  }

  Future<bool> isPortrait(File file) async {
    final fileBytes = file.readAsBytesSync();
    final exif = await readExifFromBytes(fileBytes);
    return exif.isNotEmpty &&
        exif['Image Orientation'].toString().contains('Rotated');
  }

  Future<void> createVariants() async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    final file = File(xFile!.path);

    final isPortrait = await this.isPortrait(file);

    final smallVariantResult = await createSmallVariant(file, isPortrait);
    final mediumVariantResult = await createMediumVariant(file, isPortrait);
    final largeVariantResult = await createLargeVariant(file, isPortrait);

    setState(() {
      imageCache.clear();
      imageCache.clearLiveImages();
      _original = file;
      _smallVariantResult = smallVariantResult;
      _mediumVariantResult = mediumVariantResult;
      _largeVariantResult = largeVariantResult;
    });
  }

  Future<CompressResult> createSmallVariant(File file, bool isPortrait) async {
    const width = 400;
    const height = 300;
    const inSampleSize = 8;
    const quality = 50;

    return await compressImage(
      file,
      width,
      height,
      inSampleSize,
      quality,
      isPortrait,
    );
  }

  Future<CompressResult> createMediumVariant(File file, bool isPortrait) async {
    const width = 800;
    const height = 600;
    const inSampleSize = 2;
    const quality = 50;

    return await compressImage(
      file,
      width,
      height,
      inSampleSize,
      quality,
      isPortrait,
    );
  }

  Future<CompressResult> createLargeVariant(File file, bool isPortrait) async {
    const width = 2048;
    const height = 1536;
    const inSampleSize = 2;
    const quality = 50;

    return await compressImage(
      file,
      width,
      height,
      inSampleSize,
      quality,
      isPortrait,
    );
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
                if (_smallVariantResult != null) ...[
                  const Text('small:'),
                  Image.file(
                    _smallVariantResult!.file,
                    key: UniqueKey(),
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                    isAntiAlias: true,
                  ),
                ],
                if (_mediumVariantResult != null) ...[
                  const Text('medium:'),
                  Image.file(
                    _mediumVariantResult!.file,
                    key: UniqueKey(),
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                    isAntiAlias: true,
                  ),
                ],
                if (_largeVariantResult != null) ...[
                  const Text('large:'),
                  Image.file(
                    _largeVariantResult!.file,
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
