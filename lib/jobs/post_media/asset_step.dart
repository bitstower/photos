import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
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

  AssetStep(
    this.database,
    this.secretBox,
    this.uuid,
    this.checksum,
    this.tmpDir,
  );

  @override
  Future execute(PostMediaContext context) async {
    final result = getResult(context);

    var uuid = result.getUuid();
    if (uuid == null) {
      uuid = getUuid();
      await result.setUuid(uuid);
      log.info('UUID not found in context. Generated new, uuid=$uuid');
    } else {
      log.info('UUID found in context, uuid=$uuid');
    }

    final assetFile = await getAsset(context);

    final secretKey = getSecretKey();
    await result.setSecretKey(secretKey);
    log.info('Generated secret key');

    final fileSize = await getFileSize(assetFile);
    await result.setFileSize(fileSize);
    log.info('Generated file size, fileSize=$fileSize');

    final fileType = getFileType(assetFile);
    await result.setFileType(fileType);
    log.info('Generated file type, fileType=$fileType');

    final checksum = await getChecksum(assetFile);
    await result.setChecksum(checksum);
    log.info('Generated checksum, chekcsum=$checksum');

    final assetFileEnc = await getTmpFile(uuid, 'enc');

    final secretHeader = await encrypt(assetFile, assetFileEnc, secretKey);
    await result.setSecretHeader(secretHeader);
    log.info(
      'Encrypted output file, '
      'input=${assetFile.path} output=${assetFileEnc.path}',
    );
    log.info('Generated secret header');

    await uploadFile(uuid, assetFileEnc);

    await assetFileEnc.delete();
    log.info('Deleted encrypted output file, path=${assetFileEnc.path}');

    if (!shouldKeepAsset()) {
      await assetFile.delete();
      log.info('Deleted input file, path=${assetFile.path}');
    }
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
  Future<Uint8List> encrypt(File src, File dst, Uint8List secretKey) async {
    return secretBox.encrypt(src, dst, secretKey);
  }

  @protected
  Future uploadFile(
    String uuid,
    File src,
  ) async {
    // generate upload link
    // stream and encrypt
  }
}
