import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/network_storage.dart';
import '../utils/ui.dart';

enum Menu { freeUpSpace }

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = 'Bitstower Photos';

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  final networkStorage = buildNetworkStorage();

  Widget buildGrid(int startIndex, int endIndex) {
    return GridView.builder(
      // disable scroll
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        maxCrossAxisExtent: 100.0,
      ),
      itemCount: endIndex - startIndex,
      itemBuilder: (context, index) {
        final photoIndex = index + 1 + startIndex;
        final filePath = '/dataset/thumbs/${photoIndex}.gif';
        final fileUrl = networkStorage.buildUrl(filePath);
        return GestureDetector(
            onTap: () =>
                GoRouter.of(context).go('/album/all/photo/$photoIndex'),
            child: CachedNetworkImage(
                imageUrl: fileUrl, cacheKey: filePath, fit: BoxFit.cover));
      },
    );
  }

  Widget buildEntry(String label, int startIndex, int endIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        buildGrid(startIndex, endIndex),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: Ui.getLightSystemOverlay(),
        // Here we take the value from the AlbumPage object that was created by
        // the App.build method, and use it to set our appbar title.
        // title: Text(widget.title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.backup),
            tooltip: 'Backup',
            onPressed: () => GoRouter.of(context).push('/sign-up'),
          ),
          PopupMenuButton<Menu>(
            onSelected: (Menu item) {
              GoRouter.of(context).push('/sign-up');
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
              const PopupMenuItem<Menu>(
                value: Menu.freeUpSpace,
                child: Text('Free up space'),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        // padding: const EdgeInsets.only(top: 32, bottom: 16),
        children: <Widget>[
          buildEntry('Today', 20, 25),
          buildEntry('Wednesday', 15, 20),
          buildEntry('Tue, Aug 11', 0, 15),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_photo_rounded),
            label: 'Photos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blueGrey,
      ),
    );
  }
}
