import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:photos/utils/image.dart';
import 'package:uuid/uuid.dart';

import '../utils/const.dart';
import 'job.dart';

@sealed
class PostMediaJob extends SteppableJob<JobState> {
  final log = Logger('PostMediaJob');

  final Uuid uuid;

  PostMediaJob(this.uuid, super.state) {
    addStep(
      pThumbnailSd,
      (step) => uploadThumbnail(step, ImageResolution.sd),
    );
    addStep(
      pThumbnailHd,
      (step) => uploadThumbnail(step, ImageResolution.hd),
    );
    addStep(
      pThumbnailQhd,
      (step) => uploadThumbnail(step, ImageResolution.qhd),
    );
    addStep(pOrigin, uploadOrigin);
    addStep(pJournal, updateJournal);
    addStep(pDatabase, updateDatabase);
  }

  Future uploadThumbnail(JobStepState state, ImageResolution resolution) async {
    // generate uuid
    state.setValue(pUuid, uuid.v4(), overwrite: false);

    String s = getStep(pOrigin).state.getValue(pUuid);
    // generate secret key
    // generate thumbnail (bytes)
    // collect metadata
    // encrypt data
    // upload data
  }

  Future uploadOrigin(JobStepState step) async {
    // generate uuid
    // generate checksum
    // generate secret key
    // collect metadata
    // read chunk
    // encrypt chunk
    // upload chunk
  }

  Future updateJournal(JobStepState step) async {
    // update journal

    // skip:
    // upload journal
    // update account
  }

  Future updateDatabase(JobStepState step) async {
    // media.uploaded = true
  }
}
