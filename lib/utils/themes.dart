import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class Themes {
  Themes._();

  static final light = ThemeData.light().copyWith(
    // light theme settings
    colorScheme: const ColorScheme.light(
      background: Colors.white,
    ),
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

    scaffoldBackgroundColor: Colors.white,

    inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFC4C4C4))),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),

    disabledColor: const Color.fromRGBO(30, 30, 30, 0.2),
    buttonTheme: ButtonThemeData(
        colorScheme:
            ColorScheme.fromSwatch().copyWith(background: Colors.black)),

    iconTheme: const IconThemeData(
      color: Colors.black,
    ),

    colorScheme: ColorScheme.fromSwatch()
        .copyWith(background: Colors.white, brightness: Brightness.dark),

    //  textTheme: const TextTheme(
    //   headlineSmall:
    // )
  );

  static final dark = ThemeData.dark().copyWith(
    // dark theme settings
    colorScheme: const ColorScheme.light(
      background: Colors.black,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      systemOverlayStyle: darkModeStatusBarColor,
    ),

    scaffoldBackgroundColor: Colors.black,

    inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFA4A4A4))),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),

    disabledColor: const Color.fromRGBO(205, 205, 205, 0.2),
    buttonTheme: ButtonThemeData(
        colorScheme:
            ColorScheme.fromSwatch().copyWith(background: Colors.white)),

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
