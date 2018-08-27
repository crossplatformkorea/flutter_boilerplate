import 'package:flutter/material.dart';
import 'dart:async';

import '../models/menu.dart' show Menu;
import '../utils/general.dart';

class InfiniteListView extends StatefulWidget {
  InfiniteListView({Key key}) : super(key: key);

  @override
  InfiniteListViewState createState() => new InfiniteListViewState();
}

class InfiniteListViewState extends State<InfiniteListView> {
  /// Infinite scrollview
  ScrollController _scrollController = ScrollController();
  bool _isPerformingRequest = false;

  final List<Menu> _init = [
    Menu('Title 1', 'Description 1'),
    Menu('Title 2', 'Description 2'),
    Menu('Title 3', 'Description 3'),
    Menu('Title 4', 'Description 4'),
    Menu('Title 5', 'Description 5'),
    Menu('Title 6', 'Description 6'),
    Menu('Title 7', 'Description 7'),
    Menu('Title 8', 'Description 8'),
    Menu('Title 9', 'Description 9'),
    Menu('Title 10', 'Description 10'),
  ];
  List<Menu> _list = List();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _moreData();
      }
    });

    /// fakeData
    _list = _init;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'dooboolab'
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await this._getData(reset: true);
          return null;
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverFixedExtentList(
              itemExtent: 120.0,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index == _list.length) {
                    return _buildProgressIndicator();
                  }
                  return Column(
                    children: <Widget>[
                      Container(
                        height: 120.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(_list[index].title),
                            ),
                            Container(
                              child: Text(_list[index].description),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                childCount: _isPerformingRequest ? _list.length + 1 : _list.length, /// Show spinner when fetching data
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: _isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future<void> _getData({ bool reset = false }) async {
    print('_getData');
    await Future.delayed(Duration(seconds: 1));
    if (reset) {
      this.setState(() => _list = _init);
    } else {
      this.setState(() => _list = List<Menu>.from(_list)..addAll(_init));
    }
  }

  Future<void> _moreData() async {
    print('_moreData');
    if (!this._isPerformingRequest) {
      setState(() => _isPerformingRequest = true);
      await _getData();
      setState(() {
        _isPerformingRequest = false;
      });
    }
  }
}
