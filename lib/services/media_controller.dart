import '../models/media.dart';

abstract class MediaController {
  Future<Media> getMedia(index);
  Future<int> getCount();
}
