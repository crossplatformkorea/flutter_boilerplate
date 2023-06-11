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

  void showModalTopSheet(BuildContext context, String message, Widget builder) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 500),
      barrierLabel: MaterialLocalizations.of(context).dialogLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (context, _, __) => builder,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ).drive(Tween<Offset>(
            begin: const Offset(0, -1.0),
            end: Offset.zero,
          )),
          child: child,
        );
      },
    );
  }
}
