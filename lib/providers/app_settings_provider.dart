import 'package:flutter/material.dart';

class AppSettingsProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  double _fontSizeFactor = 1.0;
  MaterialColor _themeColor = Colors.blue;

  ThemeMode get themeMode => _themeMode;
  double get fontSizeFactor => _fontSizeFactor;
  MaterialColor get themeColor => _themeColor;

  void toggleThemeMode(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setFontSizeFactor(double factor) {
    _fontSizeFactor = factor;
    notifyListeners();
  }

  void setThemeColor(MaterialColor color) {
    _themeColor = color;
    notifyListeners();
  }
}
