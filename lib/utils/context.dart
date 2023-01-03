import 'package:flutter/foundation.dart';
import 'package:msgpack_dart/msgpack_dart.dart' as msgpack;

import '../models/jar.dart';
import 'serializer.dart';
import '../services/jar_dao.dart';

class Context<T> {
  final int _jarId;
  final JarDao _jarDao;
  final Serializer<T> _serializer;

  late T _data;

  bool _initialized = false;

  Context(int jarId, JarDao jarDao, Serializer<T> serializer)
      : _jarId = jarId,
        _jarDao = jarDao,
        _serializer = serializer;

  Future init() async {
    if (_initialized) {
      return;
    }

    late Map json;

    var jar = await _jarDao.getById(_jarId);
    if (jar != null) {
      var payload = Uint8List.fromList(jar.payload);
      json = msgpack.deserialize(payload) ?? {};
    } else {
      json = {};
    }

    _data = _serializer.fromJson(json);

    _initialized = true;
  }

  Future reset() async {
    assert(_initialized);
    _data = _serializer.fromJson({});
    await persist();
  }

  Future persist() async {
    assert(_initialized);
    var json = _serializer.toJson(_data);
    var jar = Jar()
      ..id = _jarId
      ..payload = msgpack.serialize(json);
    _jarDao.put(jar);
  }

  T get data {
    assert(_initialized);
    return _data;
  }
}
