import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class Themes {
  Themes._();

  static final light = ThemeData.light().copyWith(
    // light theme settings
    backgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.black,
      ),
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 17,
      ),
      systemOverlayStyle: lightModeStatusBarColor,
    ),
  );
  static final dark = ThemeData.dark().copyWith(
    // dark theme settings
    backgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: darkModeStatusBarColor,
    ),
  );

  static void setStatusBarColors() {
    final schedulerBinding = SchedulerBinding.instance;

    Brightness brightness = schedulerBinding.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      isDarkMode ? darkModeStatusBarColor : lightModeStatusBarColor,
    );
  }
}

const darkModeStatusBarColor = SystemUiOverlayStyle(
  statusBarColor: Colors.black,
  statusBarIconBrightness: Brightness.light,
  systemNavigationBarIconBrightness: Brightness.light,
  statusBarBrightness: Brightness.dark,
);

const lightModeStatusBarColor = SystemUiOverlayStyle(
  statusBarColor: Colors.white,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarIconBrightness: Brightness.dark,
  statusBarBrightness: Brightness.light,
);
