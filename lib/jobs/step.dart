import 'package:flutter/cupertino.dart';

import '../utils/context.dart';

abstract class Step<T, E> {
  Future execute(Context<T> context);

  @protected
  E getResult(Context<T> context);
}
