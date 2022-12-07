import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:photos/states/gallery_state.dart';
import 'package:photos/widgets/media_preview.dart';
import 'package:provider/provider.dart';
import '../utils/ui.dart';

class PhotoPage extends StatefulWidget {
  final String title = 'Photo';
  final int mediaId;

  const PhotoPage(this.mediaId, {super.key});

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

showDeleteDialog(BuildContext context) {
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget deleteButton = TextButton(
    child: const Text("Delete"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title: const Text("Confirm"),
    content: const Text("Are you sure to delete this file?"),
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
  @override
  Widget build(BuildContext context) {
    var mediaIds = context.watch<GalleryState>().mediaIds;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Ui.lightNavigationBar(),
      child: Scaffold(
        backgroundColor: Colors.black,
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
          controller: PageController(
            initialPage: mediaIds.indexOf(widget.mediaId),
          ),
          clipBehavior: Clip.none,
          itemBuilder: (context, index) {
            return MediaPreview(mediaIds[index]);
          },
          itemCount: mediaIds.length,
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
