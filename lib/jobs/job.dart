import 'package:flutter/cupertino.dart';

import '../utils/context.dart';

abstract class Job<T extends Context> {
  @protected
  final T context;

  Job(this.context);

  Future execute() async {
    await context.init();
  }
}
