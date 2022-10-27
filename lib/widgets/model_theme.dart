import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'my_theme_preferences.dart';

class ModelTheme extends ChangeNotifier {
  late bool _isDark;
  late MyThemePreferences _preferences;
  bool get isDark => _isDark;

  ModelTheme() {
    _isDark = false;
    _preferences = MyThemePreferences();
    getPreferences();
  }

  toggleTheme() {
    _isDark = !_isDark;
    _preferences.setTheme(!_isDark);
    notifyListeners();
  }

  set isDark(bool value) {
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    final schedulerBinding = SchedulerBinding.instance;
    Brightness brightness = schedulerBinding.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    if (isDarkMode) {
      _isDark = isDarkMode;
      _preferences.setTheme(isDarkMode);
      notifyListeners();
      return;
    }

    _isDark = await _preferences.getTheme();
    notifyListeners();
  }
}
