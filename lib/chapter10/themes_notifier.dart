import 'package:flutter/material.dart';

class ThemesNotifier extends ChangeNotifier {
  bool _isDark = false;

  ThemeData get currentThemeData => _isDark ? darkTheme : lightTheme;

  void switchTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  useMaterial3: true,
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.orange,
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
);
