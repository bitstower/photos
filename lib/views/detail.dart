import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../services/network_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.title, required this.photoIndex});
  final String title;
  final int photoIndex;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final networkStorage = buildNetworkStorage();

  @override
  Widget build(BuildContext context) {
    final filePath = '/dataset/${widget.photoIndex}.jpg';
    final fileUrl = networkStorage.buildUrl(filePath);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.black,
          systemNavigationBarIconBrightness: Brightness.light,

          // Status bar color
          statusBarColor: Colors.transparent,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.dark, // For iOS (dark icons)

          // add shadow
          systemStatusBarContrastEnforced: true,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0, // remove shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () => GoRouter.of(context).go('/'),
        ),
      ),
      body: PhotoView(
          imageProvider:
              CachedNetworkImageProvider(fileUrl, cacheKey: filePath),
          minScale: PhotoViewComputedScale.contained),
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
          type: BottomNavigationBarType.fixed),
    );
  }
}
