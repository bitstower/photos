import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import '../services/network_storage.dart';
import '../utils/ui.dart';

class PhotoPage extends StatefulWidget {
  const PhotoPage({super.key, required this.photoIndex});
  final String title = 'Photo';
  final int photoIndex;

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  final networkStorage = buildNetworkStorage();

  ImageProvider buildImageProvider(int photoIndex) {
    final filePath = '/dataset/$photoIndex.jpg';
    final fileUrl = networkStorage.buildUrl(filePath);
    return CachedNetworkImageProvider(fileUrl, cacheKey: filePath);
  }

  int getTotalCount() {
    return 25;
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(
      initialPage: widget.photoIndex,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Ui.lightNavigationBar(),
      child: Scaffold(
        backgroundColor: Colors.black,
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          systemOverlayStyle: Ui.lightStatusBar(),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0, // remove shadow
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back',
            onPressed: () => GoRouter.of(context).go('/'),
          ),
        ),
        body: PageView.builder(
          /// [PageView.scrollDirection] defaults to [Axis.horizontal].
          /// Use [Axis.vertical] to scroll vertically.
          controller: controller,
          clipBehavior: Clip.none,
          itemBuilder: (context, index) {
            return PhotoViewGestureDetectorScope(
              axis: Axis.horizontal,
              child: PhotoView(
                imageProvider: buildImageProvider(index),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              ),
            );
          },
          itemCount: getTotalCount(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.share_outlined),
              label: 'Share',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.delete_outline),
              label: 'Delete',
            ),
          ],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
    ;
  }
}
