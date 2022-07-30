import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/widgets/responsive.dart';

class WebScreen extends StatelessWidget {
  const WebScreen({Key? key}) : super(key: key);

  Color _getBackgroundColor(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return Colors.blue;
    }

    if (Responsive.isTablet(context)) {
      return Colors.green;
    }

    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: _getBackgroundColor(context),
          child: const Center(
            child: Responsive(
              desktop: Text(
                "Desktop",
                style: TextStyle(
                  fontSize: 50,
                ),
              ),
              tablet: Text(
                "Tablet",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              mobile: Text(
                "Mobile",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
