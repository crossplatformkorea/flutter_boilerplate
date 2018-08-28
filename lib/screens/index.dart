import 'package:flutter/material.dart';

import '../utils/localization.dart';
import '../models/menu.dart' show Menu;
import '../utils/general.dart';

class Index extends StatefulWidget {
  Index({Key key}) : super(key: key);

  @override
  IndexState createState() => new IndexState();
}

class IndexState extends State<Index> {
  final List<Menu> items = [
    Menu('Infinite ListView', 'Sample for infinite ListView.'),
  ];

  @override
  Widget build(BuildContext context) {
    var localization = Localization.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'dooboolab'
        ),
      ),
      body: Center(
        child: Text(localization.trans('INTRO')),
      ),
    );
  }

  _navigate(String path) {
    General.instance.navigateScreenNamed(context, path, reset: false);
  }
}
