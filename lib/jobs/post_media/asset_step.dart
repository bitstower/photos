import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:photos/services/s3fs.dart';
import 'package:photos/utils/context.dart';
import 'package:photos/utils/s3/secret.dart';
import 'package:uuid/uuid.dart';

import '../../services/database.dart';
import '../../services/secret_box.dart';
import '../../utils/checksum.dart';
import '../../utils/tmp_dir.dart';
import '../step.dart';
import 'asset_step_result.dart';
import 'post_media_context.dart';

abstract class AssetStep extends Step<PostMediaContext, AssetStepResult> {
  @protected
  final log = Logger('AssetStep');

  @protected
  final Database database;

  @protected
  final Uuid uuid;

  @protected
  final SecretBox secretBox;

  @protected
  final Checksum checksum;

  @protected
  final TmpDir tmpDir;

  @protected
  final S3Fs s3fs;

  AssetStep(
    this.database,
    this.secretBox,
    this.uuid,
    this.checksum,
    this.tmpDir,
    this.s3fs,
  );

  @override
  Future execute(Context<PostMediaContext> context) async {
    final result = getResult(context);

    var uuid = result.uuid;
    if (uuid == null) {
      uuid = getUuid();
      result.uuid = uuid;
      await context.persist();
      log.info('Generated UUID, uuid=$uuid');
    } else {
      log.info('UUID found in the step result, uuid=$uuid');
    }

    final assetFile = await getAsset(context);

    var fileSizeFuture = fileSizeUnit(result, assetFile);
    var fileTypeFuture = fileTypeUnit(result, assetFile);
    var checksumFuture = checksumUnit(result, assetFile);
    var uploadFuture = uploadUnit(result, uuid, assetFile);

    await Future.wait([
      fileSizeFuture,
      fileTypeFuture,
      checksumFuture,
      uploadFuture,
    ]);

    await context.persist();

    if (!shouldKeepAsset()) {
      await assetFile.delete();
      log.info('Deleted input file, path=${assetFile.path}');
    }
  }

  @protected
  Future fileTypeUnit(
    AssetStepResult result,
    File assetFile,
  ) async {
    final fileType = getFileType(assetFile);
    result.fileType = fileType;
    log.info('Generated file type, fileType=$fileType');
  }

  @protected
  Future fileSizeUnit(
    AssetStepResult result,
    File assetFile,
  ) async {
    final fileSize = await getFileSize(assetFile);
    result.fileSize = fileSize;
    log.info('Generated file size, fileSize=$fileSize');
  }

  @protected
  Future checksumUnit(
    AssetStepResult result,
    File assetFile,
  ) async {
    final checksum = await getChecksum(assetFile);
    result.checksum = checksum;
    log.info('Generated checksum, chekcsum=$checksum');
  }

  @protected
  Future uploadUnit(
    AssetStepResult result,
    String uuid,
    File assetFile,
  ) async {
    final secret = await upload(uuid, assetFile);
    log.info('Uploaded file');
    result.secretKey = secret.key;
    result.secretHeader = secret.header;
    log.info('Generated secret key and header');
  }

  @override
  AssetStepResult getResult(Context<PostMediaContext> context) {
    throw UnimplementedError();
  }

  @protected
  Future<File> getAsset(Context<PostMediaContext> context);

  @protected
  bool shouldKeepAsset();

  @protected
  Future<File> getTmpFile(String name, String extension) {
    return tmpDir.getFile(name, extension);
  }

  @protected
  String getUuid() {
    return uuid.v4();
  }

  @protected
  Uint8List getSecretKey() {
    return secretBox.generateKey();
  }

  @protected
  Future<int> getFileSize(File src) {
    return src.length();
  }

  @protected
  String getFileType(File src) {
    return path.extension(src.path);
  }

  @protected
  Future<String> getChecksum(File src) {
    return checksum.generateHash(src);
  }

  @protected
  Future<Secret> upload(String uuid, File src) {
    return s3fs.put('/medias/$uuid', src);
  }
}
