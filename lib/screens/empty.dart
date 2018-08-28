import 'package:flutter/material.dart';

import '../utils/theme.dart' as Theme;
import '../utils/localization.dart' show Localization;
import '../utils/general.dart';

class Empty extends StatefulWidget {
  Empty({Key key}) : super(key: key);

  @override
  EmptyState createState() => new EmptyState();
}

class EmptyState extends State<Empty> {
  _navigate() {
    General.instance.navigateScreenNamed(context, '/empty', reset: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('Empty'),
      ),
    );
  }
}
