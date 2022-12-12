import 'package:flutter/foundation.dart';
import 'package:photos/daos/jar_dao.dart';
import 'package:msgpack_dart/msgpack_dart.dart';

import '../utils/const.dart';
import '../models/jar.dart';

abstract class Job<T extends JobState> {
  final T state;

  bool active = true;

  Job(this.state);

  Future execute() async {
    active = true;
    await state.init();
  }

  Future destroy() async {
    active = false;
  }
}

abstract class SteppableJob<T extends JobState> extends Job<T> {
  final List<JobStep> _steps = [];

  SteppableJob(super.state);

  @override
  Future execute() async {
    super.execute();
    for (var step in _steps) {
      if (!active) {
        return;
      }

      await step.execute();
    }

    await state.reset();
  }

  addStep(int key, JobStepCallback callback) {
    _steps.add(
      JobStep(
        key,
        JobStepState(key, state),
        callback,
      ),
    );
  }

  JobStep getStep(int key) {
    return _steps.firstWhere((step) => step.key == key);
  }
}

class JobState {
  final int _id;
  final JarDao _jarDao;

  late Map<int, dynamic> _data;
  bool _initialized = false;

  JobState(this._id, this._jarDao);

  Future init() async {
    var jar = await _jarDao.getById(_id);
    if (jar != null) {
      var payload = Uint8List.fromList(jar.payload);
      _data = deserialize(payload) ?? {};
    } else {
      _data = {};
    }
    _initialized = true;
  }

  Future persist() async {
    assert(_initialized);
    var jar = Jar()
      ..id = _id
      ..payload = serialize(_data);
    _jarDao.put(jar);
  }

  dynamic getValue(int key) {
    assert(_initialized);
    return _data[key];
  }

  Future setValue(
    int key,
    dynamic value, {
    bool overwrite = true,
  }) async {
    assert(_initialized);
    if (overwrite) {
      _data[key] = value;
    } else {
      _data[key] ??= value;
    }
    await persist();
  }

  Future reset() async {
    assert(_initialized);
    _data = {};
    await persist();
  }
}

class JobStepState {
  final int _key;
  final JobState _state;

  const JobStepState(this._key, this._state);

  dynamic getValue(int key) {
    return _data[key];
  }

  Future setValue(
    int key,
    dynamic value, {
    bool overwrite = true,
  }) async {
    if (overwrite) {
      _data[key] = value;
    } else {
      _data[key] ??= value;
    }
    await _state.persist();
  }

  Map<int, dynamic> get _data {
    _state.setValue(_key, {}, overwrite: false);
    return _state.getValue(_key);
  }
}

class JobStep {
  final int key;
  final JobStepState state;
  final JobStepCallback _callback;

  const JobStep(this.key, this.state, this._callback);

  Future execute() async {
    if (!isDone()) {
      return;
    }

    await _callback(state);
    await markDone();
  }

  bool isDone() {
    return state.getValue(pDone) ?? false;
  }

  Future markDone() async {
    await state.setValue(pDone, true);
  }
}

typedef JobStepCallback = Future Function(JobStepState state);
