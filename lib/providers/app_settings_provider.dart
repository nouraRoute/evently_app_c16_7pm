import 'package:flutter/material.dart';

class AppSettingsProvider extends ChangeNotifier {
  ThemeMode currantThemeMode = ThemeMode.light;
  String appLocalization = 'en';
  changeThemeMode(ThemeMode mode) {
    currantThemeMode = mode;
    notifyListeners();
  }

  changeLocal(String local) {
    appLocalization = local;
    notifyListeners();
  }
}
