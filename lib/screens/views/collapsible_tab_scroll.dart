import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_seoul/widgets/common/loading_indicator.dart';
import 'package:loading_more_list/loading_more_list.dart';

class CollapsibleTabScroll extends HookWidget {
  const CollapsibleTabScroll({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ExtendedNestedScrollViewState> globalKey =
        GlobalKey<ExtendedNestedScrollViewState>();

    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: ExtendedNestedScrollView(
            onlyOneScrollInBody: true,
            floatHeaderSlivers: false,
            key: globalKey,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  backgroundColor: Colors.white,
                  title: const Text('CollapsibleTabScroll'),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.settings),
                    )
                  ],
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 200,
                    color: Colors.black12,
                    child: const Center(
                      child: Text('Profile view'),
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: PersistentTabBar(),
                  pinned: true,
                ),
              ];
            },
            body: const TabBarView(
              children: <Widget>[
                TabViewItem(Key('Tab0')),
                TabViewItem(Key('Tab1')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.grey.shade200,
            width: 0.5,
          ),
        ),
      ),
      child: const TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.black,
        labelPadding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        labelColor: Colors.black,
        tabs: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Icon(Icons.grid_4x4_rounded),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Icon(Icons.heart_broken),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 47;

  @override
  double get minExtent => 47;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class LoadMoreListSource extends LoadingMoreBase<int> {
  int pageIndex = 1;
  bool _hasMore = true;
  bool forceRefresh = false;
  @override
  bool get hasMore => (_hasMore && length < 30) || forceRefresh;

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _hasMore = true;
    pageIndex = 1;
    //force to refresh list when you don't want clear list before request
    //for the case, if your list already has 20 items.
    forceRefresh = !notifyStateChanged;
    var result = await super.refresh(notifyStateChanged);
    forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) {
    return Future<bool>.delayed(const Duration(seconds: 1), () {
      for (int i = 0; i < 10; i++) {
        add(0);
      }

      return true;
    });
  }
}

class TabViewItem extends StatefulWidget {
  const TabViewItem(this.uniqueKey, {super.key});
  final Key uniqueKey;
  @override
  TabViewItemState createState() => TabViewItemState();
}

class TabViewItemState extends State<TabViewItem>
    with AutomaticKeepAliveClientMixin {
  late final LoadMoreListSource source = LoadMoreListSource();

  @override
  void dispose() {
    source.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Widget child = ExtendedVisibilityDetector(
      uniqueKey: widget.uniqueKey,
      child: RefreshIndicator(
        onRefresh: () {
          // return source.refresh(true);
          return Future.delayed(
            const Duration(seconds: 2),
            () {
              source.refresh(false);
            },
          );
        },
        child: LoadingMoreList<int>(
          ListConfig<int>(
            sourceList: source,
            indicatorBuilder: (context, status) {
              return const LoadingIndicator();
            },
            itemBuilder: (BuildContext c, int item, int index) {
              return widget.uniqueKey == const Key('Tab0')
                  ? ListTile(
                      tileColor: Colors.green,
                      title: Text(
                        'Item ${index + 1}',
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListTile(
                      tileColor: Colors.red,
                      title: Text(
                        'Item ${index + 1}',
                        textAlign: TextAlign.center,
                      ),
                    );
            },
          ),
        ),
      ),
    );
    return child;
  }
}
