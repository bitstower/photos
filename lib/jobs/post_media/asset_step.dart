import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:photos/services/s3fs.dart';
import 'package:photos/utils/s3/secret.dart';
import 'package:uuid/uuid.dart';

import '../../services/database.dart';
import '../../services/secret_box.dart';
import '../../utils/checksum.dart';
import '../../utils/tmp_dir.dart';
import '../step.dart';
import 'asset_step_result.dart';
import 'post_media_context.dart';

abstract class AssetStep extends Step<PostMediaContext> {
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
  Future execute(PostMediaContext context) async {
    final result = getResult(context);

    var uuid = result.getUuid();
    if (uuid == null) {
      uuid = getUuid();
      await result.setUuid(uuid);
      log.info('Generated UUID, uuid=$uuid');
    } else {
      log.info('UUID found in the step result, uuid=$uuid');
    }

    final assetFile = await getAsset(context);

    var fileSizeFuture = fileSizeAsync(result, assetFile);
    var fileTypeFuture = fileTypeAsync(result, assetFile);
    var checksumFuture = checksumAsync(result, assetFile);
    var uploadFuture = uploadAsync(result, uuid, assetFile);

    await Future.wait([
      fileSizeFuture,
      fileTypeFuture,
      checksumFuture,
      uploadFuture,
    ]);

    if (!shouldKeepAsset()) {
      await assetFile.delete();
      log.info('Deleted input file, path=${assetFile.path}');
    }
  }

  Future fileTypeAsync(
    AssetStepResult result,
    File assetFile,
  ) async {
    final fileType = getFileType(assetFile);
    await result.setFileType(fileType);
    log.info('Generated file type, fileType=$fileType');
  }

  Future fileSizeAsync(
    AssetStepResult result,
    File assetFile,
  ) async {
    final fileSize = await getFileSize(assetFile);
    await result.setFileSize(fileSize);
    log.info('Generated file size, fileSize=$fileSize');
  }

  Future checksumAsync(
    AssetStepResult result,
    File assetFile,
  ) async {
    final checksum = await getChecksum(assetFile);
    await result.setChecksum(checksum);
    log.info('Generated checksum, chekcsum=$checksum');
  }

  Future uploadAsync(
    AssetStepResult result,
    String uuid,
    File assetFile,
  ) async {
    final secret = await upload(uuid, assetFile);
    log.info('Uploaded file');

    await result.setSecretKey(secret.key);
    await result.setSecretHeader(secret.header);
    log.info('Generated secret key and header');
  }

  @override
  Future revert(PostMediaContext context) async {
    throw UnimplementedError();
  }

  @override
  AssetStepResult getResult(PostMediaContext context) {
    throw UnimplementedError();
  }

  @protected
  Future<File> getAsset(PostMediaContext context);

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
