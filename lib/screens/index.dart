import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'dooboolab'
        ),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${items[index].title}'),
            subtitle: Text('${items[index].description}'),
            onTap: () {
              this._navigate('/infinite_list_view');
            },
          );
        },
      ),
    );
  }

  _navigate(String path) {
    General.instance.navigateScreenNamed(context, path, reset: false);
  }
}
