import 'package:flutter/material.dart';

class General {
  const General._();
  static General instance = const General._();

  void showBottomSheet(
    BuildContext context,
    Widget builder,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => builder,
      // isDismissible: false,
      enableDrag: false,
    );
  }
}
