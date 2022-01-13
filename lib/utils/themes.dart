import 'package:flutter/material.dart';

class Themes {
  Themes._();

  static final light = ThemeData.light().copyWith(
    // light theme settings
    backgroundColor: Colors.white,
  );
  static final dark = ThemeData.dark().copyWith(
    // dark theme settings
    backgroundColor: Colors.black,
  );
}
