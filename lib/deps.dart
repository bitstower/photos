import 'package:get_it/get_it.dart';
import 'package:photos/jobs/post_media/post_media_job.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'services/jar_dao.dart';
import 'jobs/post_media/post_media_context.dart';
import 'jobs/post_media/origin_asset_step.dart';
import 'jobs/post_media/thumb_asset_step.dart';
import 'services/camera_roll.dart';
import 'services/database.dart';
import 'services/media_controller.dart';
import 'services/local_media_replicator.dart';
import 'services/secret_box.dart';
import 'utils/checksum.dart';
import 'utils/image_resolution.dart';
import 'utils/tmp_dir.dart';

const int _postMediaJarId = 0;

initDependencies() {
  GetIt.I.registerLazySingleton<Database>(() => Database());
  GetIt.I.registerLazySingleton<TmpDir>(() => const TmpDir());
  GetIt.I.registerLazySingleton<Checksum>(() => const Checksum());
  GetIt.I.registerLazySingleton<Uuid>(() => const Uuid());
  GetIt.I.registerLazySingleton<CameraRoll>(() => CameraRoll());
  GetIt.I.registerLazySingleton<SecretBox>(() => const SecretBox());
  GetIt.I.registerLazySingleton<JarDao>(() {
    var database = GetIt.I.get<Database>();
    return JarDao(database);
  });
  GetIt.I.registerLazySingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });
  GetIt.I.registerLazySingletonAsync<LocalMediaReplicator>(() async {
    var database = GetIt.I.get<Database>();
    var cameraRoll = GetIt.I.get<CameraRoll>();
    var options = await GetIt.I.getAsync<SharedPreferences>();
    return LocalMediaReplicator(database, cameraRoll, options);
  });
  GetIt.I.registerLazySingleton<MediaController>(() {
    var database = GetIt.I.get<Database>();
    return MediaController(database);
  });
  GetIt.I.registerLazySingleton<OriginAssetStep>(() {
    var database = GetIt.I.get<Database>();
    var secretBox = GetIt.I.get<SecretBox>();
    var uuid = GetIt.I.get<Uuid>();
    var checksum = GetIt.I.get<Checksum>();
    var tmpDir = GetIt.I.get<TmpDir>();

    return OriginAssetStep(
      database,
      secretBox,
      uuid,
      checksum,
      tmpDir,
    );
  });
  GetIt.I.registerLazySingleton<ThumbAssetStep>(
    () {
      var database = GetIt.I.get<Database>();
      var secretBox = GetIt.I.get<SecretBox>();
      var uuid = GetIt.I.get<Uuid>();
      var checksum = GetIt.I.get<Checksum>();
      var tmpDir = GetIt.I.get<TmpDir>();

      return ThumbAssetStep(
        ImageResolution.sd,
        database,
        secretBox,
        uuid,
        checksum,
        tmpDir,
      );
    },
    instanceName: 'smThumbAssetStep',
  );
  GetIt.I.registerLazySingleton<ThumbAssetStep>(
    () {
      var database = GetIt.I.get<Database>();
      var secretBox = GetIt.I.get<SecretBox>();
      var uuid = GetIt.I.get<Uuid>();
      var checksum = GetIt.I.get<Checksum>();
      var tmpDir = GetIt.I.get<TmpDir>();

      return ThumbAssetStep(
        ImageResolution.hd,
        database,
        secretBox,
        uuid,
        checksum,
        tmpDir,
      );
    },
    instanceName: 'mdThumbAssetStep',
  );
  GetIt.I.registerLazySingleton<ThumbAssetStep>(
    () {
      var database = GetIt.I.get<Database>();
      var secretBox = GetIt.I.get<SecretBox>();
      var uuid = GetIt.I.get<Uuid>();
      var checksum = GetIt.I.get<Checksum>();
      var tmpDir = GetIt.I.get<TmpDir>();

      return ThumbAssetStep(
        ImageResolution.qhd,
        database,
        secretBox,
        uuid,
        checksum,
        tmpDir,
      );
    },
    instanceName: 'lgThumbAssetStep',
  );
  GetIt.I.registerLazySingleton<PostMediaContext>(() {
    var jarDao = GetIt.I.get<JarDao>();
    return PostMediaContext(_postMediaJarId, jarDao);
  });
  GetIt.I.registerLazySingleton<PostMediaJob>(() {
    var database = GetIt.I.get<Database>();
    var originAssetStep = GetIt.I.get<OriginAssetStep>();
    var smThumbAssetStep = GetIt.I.get<ThumbAssetStep>(
      instanceName: 'smThumbAssetStep',
    );
    var mdThumbAssetStep = GetIt.I.get<ThumbAssetStep>(
      instanceName: 'mdThumbAssetStep',
    );
    var lgThumbAssetStep = GetIt.I.get<ThumbAssetStep>(
      instanceName: 'lgThumbAssetStep',
    );

    var context = GetIt.I.get<PostMediaContext>();
    return PostMediaJob(database, context, [
      smThumbAssetStep,
      mdThumbAssetStep,
      lgThumbAssetStep,
      originAssetStep,
    ]);
  });
}
