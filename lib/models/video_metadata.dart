import './metadata.dart';

class VideoMetadata extends Metadata {
  double? duration; // miliseconds

  VideoMetadata(
    super.width,
    super.height,
    super.orientation,
    super.filesize,
    super.created,
    this.duration,
  );

  int? get durationInSec {
    return duration != null ? duration! ~/ 1000 : null;
  }

  @override
  String toString() {
    return '${super.toString()} duration=$duration';
  }
}
