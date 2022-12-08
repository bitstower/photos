import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_view/photo_view.dart';

import '../services/media_controller.dart';
import '../utils/image.dart';

class MediaPreview extends StatefulWidget {
  final int mediaId;

  MediaPreview(this.mediaId, {super.key});

  @override
  State<MediaPreview> createState() => _MediaPreviewState();
}

class _MediaPreviewState extends State<MediaPreview> {
  final controller = GetIt.I.get<MediaController>();

  ImageProvider? provider;

  @override
  initState() {
    controller.getLocalAsset(widget.mediaId).then((asset) async {
      if (asset == null) {
        return;
      }

      await updateProvider(() => buildSdThumbnail(asset), preload: false);
      await updateProvider(() => buildHdThumbnail(asset));

      if (asset.type == AssetType.image) {
        await updateProvider(() => buildOriginImage(asset));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (provider != null) {
      return buildPreview(context);
    } else {
      return buildPlaceholder();
    }
  }

  Widget buildPreview(BuildContext context) {
    return PhotoViewGestureDetectorScope(
      axis: Axis.horizontal,
      child: PhotoView(
        imageProvider: provider,
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2,
        gaplessPlayback: true,
      ),
    );
  }

  Widget buildPlaceholder() {
    // TODO add waiting indicator
    return Container();
  }

  Future updateProvider(_ImageProviderFactory factory, {preload = true}) async {
    // Widget might be disposed anytime (for exmaple fast swiping).
    // Verify if the widget is still mounted after every asynchronous function.

    if (!mounted) {
      return;
    }

    var newProvider = await factory();

    if (!mounted) {
      return;
    }

    if (preload) {
      await precacheImage(newProvider, context);
    }

    if (!mounted) {
      return;
    }

    setState(() {
      provider = newProvider;
    });
  }

  Future<ImageProvider> buildSdThumbnail(AssetEntity asset) async {
    var size = ImageResolution.sd.findClosestSize(
      ImageSize(
        asset.orientatedWidth,
        asset.orientatedHeight,
      ),
    );
    var bytes = await asset.thumbnailDataWithSize(
      ThumbnailSize(size.width, size.height),
      quality: ImageResolution.sd.quality,
    );
    return Image.memory(
      bytes!,
      // Improve the quality of the scaled up image
      filterQuality: FilterQuality.medium,
    ).image;
  }

  Future<ImageProvider> buildHdThumbnail(AssetEntity asset) async {
    var size = ImageResolution.hd.findClosestSize(
      ImageSize(
        asset.orientatedWidth,
        asset.orientatedHeight,
      ),
    );
    var bytes = await asset.thumbnailDataWithSize(
      ThumbnailSize(size.width, size.height),
      quality: ImageResolution.hd.quality,
    );
    return Image.memory(
      bytes!,
    ).image;
  }

  Future<ImageProvider> buildOriginImage(AssetEntity asset) async {
    var file = await asset.originFile;
    return Image.file(file!).image;
  }
}

typedef _ImageProviderFactory = Future<ImageProvider> Function();
