import 'package:flutter/foundation.dart';

class StepResult {
  @protected
  final String prefix;

  @protected
  final GetValueCallback getValueCallback;

  @protected
  final SetValueCallback setValueCallback;

  const StepResult(
    this.prefix,
    this.getValueCallback,
    this.setValueCallback,
  );

  @protected
  dynamic getValue(String key) {
    return getValueCallback('$prefix.$key');
  }

  @protected
  Future setValue(String key, dynamic value) async {
    await setValueCallback('$prefix.$key', value);
  }
}

typedef GetValueCallback = dynamic Function(String key);
typedef SetValueCallback = Future Function(String key, dynamic value);
