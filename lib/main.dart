import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:photos/services/camera_roll.dart';
import 'package:photos/services/database.dart';
import 'package:photos/services/media_controller.dart';
import 'package:photos/services/local_media_store.dart';
import 'package:photos/states/gallery_state.dart';
import 'package:photos/views/debug_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'views/photo.dart';
import 'views/album.dart';
import 'views/vendors.dart';
import 'views/sign_in.dart';
import 'views/sign_up.dart';
import 'views/setup_vendor.dart';
import 'views/setup_access.dart';

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

initDependencies() {
  GetIt.I.registerLazySingleton<Database>(() => Database());
  GetIt.I.registerLazySingleton<CameraRoll>(() => CameraRoll());
  GetIt.I.registerLazySingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });
  GetIt.I.registerLazySingletonAsync<LocalMediaStore>(() async {
    var database = GetIt.I.get<Database>();
    var cameraRoll = GetIt.I.get<CameraRoll>();
    var options = await GetIt.I.getAsync<SharedPreferences>();
    return LocalMediaStore(database, cameraRoll, options);
  });
  GetIt.I.registerLazySingleton<MediaController>(() {
    var database = GetIt.I.get<Database>();
    return MediaController(database);
  });
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
