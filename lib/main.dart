import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photos/views/detail.dart';
import 'views/photos.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Bitstower Photos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const MyHomePage(title: 'Bitstower Photos');
        },
      ),
      GoRoute(
        path: '/detail/:photoIndex',
        builder: (BuildContext context, GoRouterState state) {
          return DetailPage(
              title: 'Photo',
              photoIndex: int.parse(state.params['photoIndex']!));
        },
      ),
    ],
  );
}
