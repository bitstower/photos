import 'package:flutter/foundation.dart';
import 'package:msgpack_dart/msgpack_dart.dart';

import '../models/jar.dart';
import '../services/jar_dao.dart';

abstract class Context {
  final int _jarId;
  final JarDao _jarDao;

  late Map<String, dynamic> _data;

  bool _initialized = false;

  Context(int jarId, JarDao jarDao)
      : _jarId = jarId,
        _jarDao = jarDao;

  Future init() async {
    var jar = await _jarDao.getById(_jarId);
    if (jar != null) {
      var payload = Uint8List.fromList(jar.payload);
      _data = deserialize(payload) ?? {};
    } else {
      _data = {};
    }
    _initialized = true;
  }

  @protected
  dynamic getValue(String key) {
    assert(_initialized);
    return _data[key];
  }

  @protected
  Future setValue(String key, dynamic value) async {
    assert(_initialized);
    _data[key] = value;
    await _persist();
  }

  Future reset() async {
    assert(_initialized);
    _data = {};
    await _persist();
  }

  Future _persist() async {
    assert(_initialized);
    var jar = Jar()
      ..id = _jarId
      ..payload = serialize(_data);
    _jarDao.put(jar);
  }
}
