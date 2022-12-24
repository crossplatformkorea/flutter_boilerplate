import 'package:shared_preferences/shared_preferences.dart';

class MyThemePreferences {
  static const themeKey = 'theme_key';

  Future<void> setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(themeKey, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(themeKey) ?? false;
  }
}
