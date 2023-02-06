import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class Themes {
  Themes._();

  static final light = ThemeData.light().copyWith(
    primaryColor: AppColors.role.primary,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.role.basic,
      ),
      actionsIconTheme: IconThemeData(
        color: AppColors.role.basic,
      ),
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.role.basic,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      systemOverlayStyle: lightModeStatusBarColor,
      toolbarTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.text.basic,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.role.basic,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.bg.borderContrast,
      background: Colors.white,
      primary: AppColors.text.basic,
    ),
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
  );

  static void setStatusBarColors() {
    SystemChrome.setSystemUIOverlayStyle(
      lightModeStatusBarColor,
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
