import 'package:meta/meta.dart';
import 'package:photos/jobs/post_media/asset_step_result.dart';
import 'package:photos/journal/record.dart';
import 'package:photos/journal/journal_dao.dart';
import 'package:photos/services/media_dao.dart';
import 'package:photos/utils/context.dart';
import 'package:photos/utils/dummy.dart';

import '../step.dart';
import 'post_media_context.dart';

class JournalStep extends Step<PostMediaContext, Dummy> {
  final JournalDao _journalDao;
  final MediaDao _mediaDao;

  JournalStep(this._journalDao, this._mediaDao);

  @override
  Future execute(Context<PostMediaContext> context) async {
    final mediaId = context.data.mediaId;
    assert(mediaId != null);

    final media = await _mediaDao.getById(mediaId!);
    assert(media != null);

    _journalDao.addRecord(
      Record(
        type: RecordType.postMedia,
        payload: PostMedia(
          type: media!.type.value,
          taken: media.taken,
          orientatedHeight: media.orientatedHeight,
          orientatedWidth: media.orientatedWidth,
          orientation: media.orientation,
          duration: media.duration,
          originAsset: buildAsset(context.data.originAssetStep),
          smThumbAsset: buildAsset(context.data.smThumbAssetStep),
          mdThumbAsset: buildAsset(context.data.mdThumbAssetStep),
          lgThumbAsset: buildAsset(context.data.lgThumbAssetStep),
        ),
      ),
    );
  }

  @protected
  buildAsset(AssetStepResult src) {
    return Asset(
      uuid: src.uuid!,
      secretKey: src.secretKey!,
      secretHeader: src.secretHeader!,
      checksum: src.checksum!,
      fileSize: src.fileSize!,
      fileType: src.fileType!,
    );
  }

  @override
  Dummy getResult(Context<PostMediaContext> context) {
    throw UnimplementedError();
  }
}
