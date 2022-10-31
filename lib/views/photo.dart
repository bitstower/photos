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

showDeleteDialog(BuildContext context) {
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget deleteButton = TextButton(
    child: Text("Delete"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Confirm"),
    content: Text("Are you sure to delete this file?"),
    actions: [
      cancelButton,
      deleteButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
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
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back',
            onPressed: () => GoRouter.of(context).go('/'),
          ),
        ),
        body: PageView.builder(
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
          onTap: ((value) {
            showDeleteDialog(context);
          }),
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
