import 'package:meta/meta.dart';
import 'package:photos/jobs/post_media/asset_step_result.dart';
import 'package:photos/jobs/step_result.dart';
import 'package:photos/journal/record.dart';
import 'package:photos/journal/record_type.dart';
import 'package:photos/journal/journal_dao.dart';
import 'package:photos/journal/post_media/asset_view.dart';
import 'package:photos/journal/post_media/post_media_view.dart';
import 'package:photos/services/media_dao.dart';

import '../step.dart';
import 'post_media_context.dart';

class JournalStep extends Step<PostMediaContext> {
  @protected
  final JournalDao journalDao;

  @protected
  final MediaDao mediaDao;

  JournalStep(this.journalDao, this.mediaDao);

  @override
  Future execute(PostMediaContext context) async {
    final mediaId = context.getMediaId();
    assert(mediaId != null);

    final media = await mediaDao.getById(mediaId!);
    assert(media != null);

    final event = Record(type: RecordType.postMedia);
    final view = PostMediaView(event);

    view
      ..setType(media!.type.value)
      ..setTaken(media.taken)
      ..setOrientatedHeight(media.orientatedHeight)
      ..setOrientatedWidth(media.orientatedWidth)
      ..setOrientation(media.orientation)
      ..setDuration(media.duration);

    copyAsset(context.smThumbAssetStep, view.getSmThumbAsset());
    copyAsset(context.mdThumbAssetStep, view.getMdThumbAsset());
    copyAsset(context.lgThumbAssetStep, view.getLgThumbAsset());
    copyAsset(context.originAssetStep, view.getOriginAsset());

    journalDao.addRecord(event);
  }

  @protected
  copyAsset(AssetStepResult src, AssetView dst) {
    dst
      ..setUuid(src.getUuid()!)
      ..setSecretKey(src.getSecretKey()!)
      ..setSecretHeader(src.getSecretHeader()!)
      ..setChecksum(src.getChecksum()!)
      ..setFileSize(src.getFileSize()!)
      ..setFileType(src.getFileType()!);
  }

  @override
  StepResult getResult(PostMediaContext context) {
    throw UnimplementedError();
  }

  @override
  Future revert(PostMediaContext context) {
    throw UnimplementedError();
  }
}
