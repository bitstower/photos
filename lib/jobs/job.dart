import 'package:flutter/cupertino.dart';

import '../utils/context.dart';

abstract class Job<T> {
  @protected
  final Context<T> context;

  Job(this.context);

  Future execute() async {
    await context.init();
  }
}
