import 'package:get_it/get_it.dart';
import 'package:photos/jobs/post_media/asset_step_result.dart';
import 'package:photos/jobs/post_media/broadcast_step.dart';
import 'package:photos/jobs/post_media/journal_step.dart';
import 'package:photos/jobs/post_media/post_media_job.dart';
import 'package:photos/journal/journal_context.dart';
import 'package:photos/journal/journal_dao.dart';
import 'package:photos/journal/journal_repository.dart';
import 'package:photos/journal/record_serializer.dart' as journal;
import 'package:photos/services/account.dart';
import 'package:photos/services/media_dao.dart';
import 'package:photos/services/s3fs.dart';
import 'package:photos/utils/context.dart';
import 'package:photos/utils/s3/s3_factory.dart';
import 'package:photos/utils/s3/storj_factory.dart';
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
const int _accountJarId = 1;
const int _journalJarId = 2;

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
  GetIt.I.registerLazySingleton<MediaDao>(() {
    var database = GetIt.I.get<Database>();
    return MediaDao(database);
  });
  GetIt.I.registerLazySingleton<JournalContextSerializer>(() {
    return JournalContextSerializer();
  });
  GetIt.I.registerLazySingleton<Context<JournalContext>>(() {
    var jarDao = GetIt.I.get<JarDao>();
    var serializer = GetIt.I.get<JournalContextSerializer>();
    return Context<JournalContext>(_journalJarId, jarDao, serializer);
  });
  GetIt.I.registerLazySingleton<JournalRepository>(() {
    var account = GetIt.I.get<Account>();
    var s3fs = GetIt.I.get<S3Fs>();
    var context = GetIt.I.get<Context<JournalContext>>();
    return JournalRepository(context, account, s3fs);
  });
  GetIt.I.registerLazySingleton<journal.AssetSerializer>(() {
    return journal.AssetSerializer();
  });
  GetIt.I.registerLazySingleton<journal.PostMediaSerializer>(() {
    var assetSerializer = GetIt.I.get<journal.AssetSerializer>();
    return journal.PostMediaSerializer(assetSerializer);
  });
  GetIt.I.registerLazySingleton<journal.RecordSerializer>(() {
    var postMediaSerializer = GetIt.I.get<journal.PostMediaSerializer>();
    return journal.RecordSerializer(postMediaSerializer);
  });
  GetIt.I.registerLazySingleton<JournalDao>(() {
    var repository = GetIt.I.get<JournalRepository>();
    var serializer = GetIt.I.get<journal.RecordSerializer>();
    return JournalDao(repository, serializer);
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
  GetIt.I.registerLazySingleton<AccountContextSerializer>(() {
    return AccountContextSerializer();
  });
  GetIt.I.registerLazySingleton<Context<AccountContext>>(() {
    var jarDao = GetIt.I.get<JarDao>();
    var serializer = GetIt.I.get<AccountContextSerializer>();
    return Context<AccountContext>(_accountJarId, jarDao, serializer);
  });
  GetIt.I.registerLazySingleton<Account>(() {
    var context = GetIt.I.get<Context<AccountContext>>();
    var uuid = GetIt.I.get<Uuid>();
    return Account(uuid, context);
  });
  GetIt.I.registerLazySingleton<S3Factory>(() {
    var account = GetIt.I.get<Account>();
    return StorjFactory(account);
  });
  GetIt.I.registerLazySingleton<S3Fs>(() {
    var s3Factory = GetIt.I.get<S3Factory>();
    var secretBox = GetIt.I.get<SecretBox>();
    var tmpDir = GetIt.I.get<TmpDir>();
    var uuid = GetIt.I.get<Uuid>();
    return S3Fs(s3Factory, secretBox, tmpDir, uuid);
  });
  GetIt.I.registerLazySingleton<ThumbAssetStep>(
    () {
      var database = GetIt.I.get<Database>();
      var secretBox = GetIt.I.get<SecretBox>();
      var uuid = GetIt.I.get<Uuid>();
      var checksum = GetIt.I.get<Checksum>();
      var tmpDir = GetIt.I.get<TmpDir>();
      var s3Fs = GetIt.I.get<S3Fs>();

      return ThumbAssetStep(
        ImageResolution.sd,
        database,
        secretBox,
        uuid,
        checksum,
        tmpDir,
        s3Fs,
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
      var s3Fs = GetIt.I.get<S3Fs>();

      return ThumbAssetStep(
        ImageResolution.hd,
        database,
        secretBox,
        uuid,
        checksum,
        tmpDir,
        s3Fs,
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
      var s3Fs = GetIt.I.get<S3Fs>();

      return ThumbAssetStep(
        ImageResolution.qhd,
        database,
        secretBox,
        uuid,
        checksum,
        tmpDir,
        s3Fs,
      );
    },
    instanceName: 'lgThumbAssetStep',
  );
  GetIt.I.registerLazySingleton<OriginAssetStep>(() {
    var database = GetIt.I.get<Database>();
    var secretBox = GetIt.I.get<SecretBox>();
    var uuid = GetIt.I.get<Uuid>();
    var checksum = GetIt.I.get<Checksum>();
    var tmpDir = GetIt.I.get<TmpDir>();
    var s3Fs = GetIt.I.get<S3Fs>();

    return OriginAssetStep(
      database,
      secretBox,
      uuid,
      checksum,
      tmpDir,
      s3Fs,
    );
  });
  GetIt.I.registerLazySingleton<JournalStep>(() {
    var mediaDao = GetIt.I.get<MediaDao>();
    var journalDao = GetIt.I.get<JournalDao>();
    return JournalStep(journalDao, mediaDao);
  });
  GetIt.I.registerLazySingleton<BroadcastStep>(() {
    var mediaDao = GetIt.I.get<MediaDao>();
    return BroadcastStep(mediaDao);
  });
  GetIt.I.registerLazySingleton<AssetStepResultSerializer>(() {
    return AssetStepResultSerializer();
  });
  GetIt.I.registerLazySingleton<PostMediaContextSerializer>(() {
    var assetSerializer = GetIt.I.get<AssetStepResultSerializer>();
    return PostMediaContextSerializer(assetSerializer);
  });
  GetIt.I.registerLazySingleton<Context<PostMediaContext>>(() {
    var jarDao = GetIt.I.get<JarDao>();
    var serializer = GetIt.I.get<PostMediaContextSerializer>();
    return Context<PostMediaContext>(_postMediaJarId, jarDao, serializer);
  });
  GetIt.I.registerLazySingleton<PostMediaJob>(() {
    var database = GetIt.I.get<Database>();
    var journalRepo = GetIt.I.get<JournalRepository>();
    var smThumbAssetStep = GetIt.I.get<ThumbAssetStep>(
      instanceName: 'smThumbAssetStep',
    );
    var mdThumbAssetStep = GetIt.I.get<ThumbAssetStep>(
      instanceName: 'mdThumbAssetStep',
    );
    var lgThumbAssetStep = GetIt.I.get<ThumbAssetStep>(
      instanceName: 'lgThumbAssetStep',
    );
    var originAssetStep = GetIt.I.get<OriginAssetStep>();
    var journalStep = GetIt.I.get<JournalStep>();
    var broadcastStep = GetIt.I.get<BroadcastStep>();

    var context = GetIt.I.get<Context<PostMediaContext>>();
    return PostMediaJob(
      database,
      context,
      journalRepo,
      smThumbAssetStep,
      mdThumbAssetStep,
      lgThumbAssetStep,
      originAssetStep,
      journalStep,
      broadcastStep,
    );
  });
}
