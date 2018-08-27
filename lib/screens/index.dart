import 'package:flutter/material.dart';

import '../utils/general.dart';

class Index extends StatefulWidget {
  Index({Key key}) : super(key: key);

  @override
  IndexState createState() => new IndexState();
}

class IndexState extends State<Index> {
  _navigate() {
    General.instance.navigateScreenNamed(context, '/index', reset: true);
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
