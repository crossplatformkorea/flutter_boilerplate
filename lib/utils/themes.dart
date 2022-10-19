import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class Themes {
  Themes._();

  static final light = ThemeData.light().copyWith(
    // light theme settings
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
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
    buttonColor: Colors.black,
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(background: Colors.white, brightness: Brightness.dark),
  );
  static final dark = ThemeData.dark().copyWith(
    // dark theme settings
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      systemOverlayStyle: darkModeStatusBarColor,
    ),
    buttonColor: Colors.white,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(background: Colors.black, brightness: Brightness.light),
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
