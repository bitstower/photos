import 'package:cached_network_image/cached_network_image.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../services/network_storage.dart';
import '../utils/ui.dart';

enum Menu { freeUpSpace, settings, image_debug }

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});

  final String title = 'Bitstower Photos';

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final networkStorage = buildNetworkStorage();

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Ui.darkNavigationBar(contrastEnforced: true),
      child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: Ui.darkStatusBar(),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title: Text('Photos'),
            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.backup),
                tooltip: 'Backup',
                onPressed: () => GoRouter.of(context).push('/sign-up'),
              ),
              PopupMenuButton<Menu>(
                onSelected: (Menu item) {
                  if (item == Menu.image_debug) {
                    GoRouter.of(context).pushNamed('image_debug');
                  } else {
                    GoRouter.of(context).push('/sign-up');
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                  const PopupMenuItem<Menu>(
                    value: Menu.freeUpSpace,
                    child: Text('Free up space'),
                  ),
                  const PopupMenuItem<Menu>(
                    value: Menu.settings,
                    child: Text('Settings'),
                  ),
                  const PopupMenuItem<Menu>(
                    value: Menu.image_debug,
                    child: Text('Image Debug'),
                  ),
                ],
              ),
            ],
          ),
          body: RefreshIndicator(
            key: _refreshIndicatorKey,
            color: Colors.white,
            backgroundColor: Colors.blueGrey,
            strokeWidth: 2.0,
            onRefresh: () async {
              // TODO
              return Future<void>.delayed(const Duration(seconds: 3));
            },
            child: DraggableScrollbar.semicircle(
              controller: _scrollController,
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                  maxCrossAxisExtent: 100.0,
                ),
                itemCount: 25 * 10,
                itemBuilder: (context, index) {
                  final photoIndex = (index % 24) + 1;
                  final filePath = '/dataset/thumbs/${photoIndex}.gif';
                  final fileUrl = networkStorage.buildUrl(filePath);
                  return GestureDetector(
                      onTap: () => GoRouter.of(context)
                          .go('/album/all/photo/$photoIndex'),
                      child: CachedNetworkImage(
                          imageUrl: fileUrl,
                          cacheKey: filePath,
                          fit: BoxFit.cover));
                },
              ),
            ),
          )),
    );
  }
}
