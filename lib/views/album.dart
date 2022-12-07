import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:photos/states/gallery_state.dart';
import 'package:photos/widgets/media_thumbnail.dart';
import 'package:provider/provider.dart';
import '../utils/ui.dart';

enum Menu { freeUpSpace, settings, debug }

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});

  final String title = 'Bitstower Photos';

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var mediaIds = context.watch<GalleryState>().mediaIds;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Ui.darkNavigationBar(contrastEnforced: true),
      child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: Ui.darkStatusBar(),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title: const Text('Photos'),
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
                  if (item == Menu.debug) {
                    GoRouter.of(context).push('/debug');
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
                  if (kDebugMode) ...[
                    const PopupMenuItem<Menu>(
                      value: Menu.debug,
                      child: Text('Debug'),
                    ),
                  ]
                ],
              ),
            ],
          ),
          body: RefreshIndicator(
            key: _refreshIndicatorKey,
            color: Colors.white,
            backgroundColor: Colors.blueGrey,
            strokeWidth: 2.0,
            onRefresh: () async {},
            child: DraggableScrollbar.semicircle(
              controller: _scrollController,
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                  maxCrossAxisExtent: 100.0,
                ),
                itemCount: mediaIds.length,
                itemBuilder: (context, index) {
                  return MediaThumbnail(mediaIds[index]);
                },
              ),
            ),
          )),
    );
  }
}
