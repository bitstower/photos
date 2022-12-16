import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'views/photo.dart';
import 'views/album.dart';
import 'views/vendors.dart';
import 'views/sign_in.dart';
import 'views/sign_up.dart';
import 'views/setup_vendor.dart';
import 'views/setup_access.dart';
import 'views/debug_page.dart';
import 'services/media_controller.dart';
import 'states/gallery_state.dart';
import 'deps.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kDebugMode) {
    Logger.root.level = Level.FINE;
  }
  if (kReleaseMode) {
    Logger.root.level = Level.WARNING;
  }

  Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print(
      '[${record.loggerName}] [${record.level.name}] [${record.time}] '
      '${record.message}',
    );
  });

  initDependencies();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<GalleryState>(
          create: (_) => createGalleryState(),
        ),
      ],
      child: App(),
    ),
  );
}

GalleryState createGalleryState() {
  var controller = GetIt.I.get<MediaController>();
  return GalleryState()..mediaIds = controller.getIdsSync();
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
            path: 'media/:id',
            builder: (BuildContext context, GoRouterState state) {
              return PhotoPage(
                int.parse(state.params['id']!),
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
        path: '/debug',
        builder: (BuildContext context, GoRouterState state) {
          return const DebugPage();
        },
      ),
    ],
  );
}
