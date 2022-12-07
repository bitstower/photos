import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photos/services/media_controller.dart';

class MediaThumbnail extends StatelessWidget {
  final int id;

  const MediaThumbnail(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    var controller = GetIt.I.get<MediaController>();
    return FutureBuilder<AssetEntity?>(
      future: controller.getLocalAsset(id),
      builder: (
        BuildContext context,
        AsyncSnapshot<AssetEntity?> snapshot,
      ) {
        return snapshot.hasData
            ? buildThumbnail(context, snapshot.data!)
            : buildPlaceholder();
      },
    );
  }

  Widget buildThumbnail(BuildContext context, AssetEntity localAsset) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).go('/album/all/media/$id');
      },
      child: AssetEntityImage(
        localAsset,
        isOriginal: false,
        thumbnailSize: const ThumbnailSize.square(200),
        thumbnailFormat: ThumbnailFormat.jpeg,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.medium,
      ),
    );
  }

  Widget buildPlaceholder() {
    return Container(color: const Color(0xffd3d3d3));
  }
}
