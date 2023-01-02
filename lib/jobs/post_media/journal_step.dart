import 'package:meta/meta.dart';
import 'package:photos/jobs/post_media/asset_step_result.dart';
import 'package:photos/jobs/step_result.dart';
import 'package:photos/journal/record.dart';
import 'package:photos/journal/journal_dao.dart';
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

    var payload = PostMedia(
      type: media!.type.value,
      taken: media.taken,
      orientatedHeight: media.orientatedHeight,
      orientatedWidth: media.orientatedWidth,
      orientation: media.orientation,
      duration: media.duration,
      originAsset: buildAsset(context.originAssetStep),
      smThumbAsset: buildAsset(context.smThumbAssetStep),
      mdThumbAsset: buildAsset(context.mdThumbAssetStep),
      lgThumbAsset: buildAsset(context.lgThumbAssetStep),
    );

    journalDao.addRecord(
      Record(
        type: RecordType.postMedia,
        payload: payload,
      ),
    );
  }

  @protected
  buildAsset(AssetStepResult src) {
    return Asset(
      uuid: src.getUuid()!,
      secretKey: src.getSecretKey()!,
      secretHeader: src.getSecretHeader()!,
      checksum: src.getChecksum()!,
      fileSize: src.getFileSize()!,
      fileType: src.getFileType()!,
    );
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
