import 'package:flutter/material.dart';
/*
class AppTheme {
  final bool isDarkmode;

  AppTheme({required this.isDarkmode});

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
      );
}
*/

class AppTheme {
  final bool isDarkmode;
  final ColorScheme _darkColorScheme = ColorScheme.dark(
      // ...
      );
  final ColorScheme _lightColorScheme = ColorScheme.light(
      // ...
      );

  AppTheme({required this.isDarkmode});

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
        colorScheme: isDarkmode ? _darkColorScheme : _lightColorScheme,
      );
}
