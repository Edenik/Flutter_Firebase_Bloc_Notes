import 'package:flutter/material.dart';

enum AppTheme {
  LightTheme,
  DarkTheme,
}

class Themes {
  static final Map<AppTheme, ThemeData> themeData = {
    AppTheme.LightTheme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white),
    AppTheme.DarkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.grey[800],
        scaffoldBackgroundColor: Colors.grey[800])
  };
}
