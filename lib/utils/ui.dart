import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Ui {
  static SystemUiOverlayStyle getLightSystemOverlay() {
    return const SystemUiOverlayStyle(
      statusBarColor: Colors.white,

      // For Android (dark icons)
      statusBarIconBrightness: Brightness.dark,

      // For iOS (dark icons)
      statusBarBrightness: Brightness.light,

      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
  }

  static SystemUiOverlayStyle getDarkSystemOverlay() {
    return const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,

      // For Android (light icons)
      statusBarIconBrightness: Brightness.light,

      // For iOS (light icons)
      statusBarBrightness: Brightness.dark,

      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,

      // Adds background shadow
      systemStatusBarContrastEnforced: true,
    );
  }

  static const bodyTextStyle = TextStyle(color: Colors.black);
  static const linkStyle = TextStyle(color: Colors.blue);
}
