import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photos/views/sign_in.dart';
import 'package:photos/views/sign_up.dart';
import 'views/detail.dart';
import 'views/photos.dart';
import 'views/vendors.dart';
import 'views/sign_in.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
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
      GoRoute(
        path: '/vendors',
        builder: (BuildContext context, GoRouterState state) {
          return const VendorsPage(
            title: 'Vendors',
          );
        },
      ),
      GoRoute(
        path: '/sign-in',
        builder: (BuildContext context, GoRouterState state) {
          return const SignInPage(
            title: 'Sign In',
          );
        },
      ),
      GoRoute(
        path: '/sign-up',
        builder: (BuildContext context, GoRouterState state) {
          return const SignUpPage();
        },
      ),
    ],
  );
}
