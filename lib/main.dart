import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'views/photo.dart';
import 'views/album.dart';
import 'views/vendors.dart';
import 'views/sign_in.dart';
import 'views/sign_up.dart';
import 'views/setup_vendor.dart';
import 'views/setup_access.dart';
import 'views/image_debug.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

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
        name: 'home',
        path: '/',
        redirect: (BuildContext context, GoRouterState state) {
          return '/album/all';
        },
      ),
      GoRoute(
        path: '/album/all',
        builder: (BuildContext context, GoRouterState state) {
          return const AlbumPage();
        },
        routes: [
          GoRoute(
            path: 'photo/:photoIndex',
            builder: (BuildContext context, GoRouterState state) {
              return PhotoPage(
                photoIndex: int.parse(
                  state.params['photoIndex']!,
                ),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: '/vendors',
        builder: (BuildContext context, GoRouterState state) {
          return const VendorsPage();
        },
      ),
      GoRoute(
        path: '/sign-in',
        builder: (BuildContext context, GoRouterState state) {
          return const SignInPage();
        },
      ),
      GoRoute(
        path: '/sign-up',
        builder: (BuildContext context, GoRouterState state) {
          return const SignUpPage();
        },
      ),
      GoRoute(
        path: '/setup-vendor',
        builder: (BuildContext context, GoRouterState state) {
          return const SetupVendorPage();
        },
      ),
      GoRoute(
        path: '/setup-access',
        builder: (BuildContext context, GoRouterState state) {
          return const SetupAccessPage();
        },
      ),
      GoRoute(
        name: 'image_debug',
        path: '/image-debug',
        builder: (BuildContext context, GoRouterState state) {
          return const ImageDebugPage();
        },
      ),
    ],
  );
}
