import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:photos/services/media_controller.dart';

class GalleryState extends ChangeNotifier {
  UnmodifiableListView<int> _mediaIds = UnmodifiableListView([]);

  UnmodifiableListView<int> get mediaIds => _mediaIds;

  set mediaIds(List<int> value) {
    _mediaIds = UnmodifiableListView(value);
    notifyListeners();
  }
}
