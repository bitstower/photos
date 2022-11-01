import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Ui {
  // Important:
  //
  // Set navigation bar style using AnnotatedRegion.
  // Set status bar style using Scaffold.appBar.systemOverlayStyle

  static SystemUiOverlayStyle lightStatusBar() {
    return const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemStatusBarContrastEnforced: false,
    );
  }

  static SystemUiOverlayStyle darkStatusBar() {
    return const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemStatusBarContrastEnforced: false,
    );
  }

  static SystemUiOverlayStyle lightNavigationBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: null,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarContrastEnforced: false,
    );
  }

  static SystemUiOverlayStyle darkNavigationBar(
      {bool contrastEnforced = false}) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: null,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarContrastEnforced: contrastEnforced,
    );
  }

  static const bodyTextStyle = TextStyle(color: Colors.black);
  static const linkStyle = TextStyle(color: Colors.blue);
}
