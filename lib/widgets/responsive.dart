import 'package:flutter/material.dart';

const mobileMaxWith = 850;
const tableMaxWith = 1100;

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileMaxWith;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < tableMaxWith &&
      MediaQuery.of(context).size.width >= mobileMaxWith;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tableMaxWith;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    if (_size.width >= tableMaxWith) {
      return desktop;
    } else if (_size.width >= mobileMaxWith && tablet != null) {
      return tablet!;
    }

    return mobile;
  }
}
