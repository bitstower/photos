import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_view/photo_view.dart';

import '../services/media_controller.dart';

class MediaPreview extends StatelessWidget {
  final int mediaId;

  const MediaPreview(this.mediaId, {super.key});

  @override
  Widget build(BuildContext context) {
    var controller = GetIt.I.get<MediaController>();

    return FutureBuilder<AssetEntity?>(
      future: controller.getLocalAsset(mediaId),
      builder: (
        BuildContext context,
        AsyncSnapshot<AssetEntity?> snapshot,
      ) {
        return snapshot.hasData
            ? buildPreview(context, snapshot.data!)
            : buildPlaceholder();
      },
    );
  }

  Widget buildPreview(BuildContext context, AssetEntity localAsset) {
    return PhotoViewGestureDetectorScope(
      axis: Axis.horizontal,
      child: PhotoView(
        imageProvider: AssetEntityImageProvider(
          localAsset,
          isOriginal: true,
        ),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2,
      ),
    );
  }

  Widget buildPlaceholder() {
    return Container();
  }
}
