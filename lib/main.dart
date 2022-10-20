import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'network_storage.dart';

void main() {
  runApp(const MyApp());
}

NetworkStorage buildNetworkStorage() {
  const bucketName = String.fromEnvironment("S3_BUCKET_NAME");
  const accessKey = String.fromEnvironment("S3_ACCESS_KEY");
  const secretKey = String.fromEnvironment("S3_SECRET_KEY");

  assert(bucketName.isNotEmpty);
  assert(accessKey.isNotEmpty);
  assert(secretKey.isNotEmpty);

  return StorjStorage(bucketName, accessKey, secretKey);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitstower Photos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blueGrey),
      home: const MyHomePage(title: 'Bitstower Photos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final networkStorage = buildNetworkStorage();

  Widget buildGrid(int startIndex, int endIndex) {
    return GridView.builder(
      // disable scroll
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        maxCrossAxisExtent: 100.0,
      ),
      itemCount: endIndex - startIndex,
      itemBuilder: (context, index) {
        final filePath = '/dataset/thumbs/${index + 1 + startIndex}.gif';
        final fileUrl = networkStorage.buildUrl(filePath);
        return CachedNetworkImage(
            imageUrl: fileUrl, cacheKey: filePath, fit: BoxFit.cover);
      },
    );
  }

  Widget buildEntry(String label, int startIndex, int endIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w600),
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
        systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Colors.white,

            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)

            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        // title: Text(widget.title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: const Icon(Icons.search_rounded),
        actions: [
          IconButton(
            icon: const Icon(Icons.backup),
            tooltip: 'Backup photos',
            onPressed: () {},
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
            icon: Icon(Icons.photo_album_outlined),
            label: 'Albums',
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
