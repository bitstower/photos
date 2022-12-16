import 'package:flutter/cupertino.dart';

import '../utils/context.dart';
import 'step_result.dart';

abstract class Step<T extends Context> {
  Future execute(T context);
  Future revert(T context);

  @protected
  StepResult getResult(T context);
}
