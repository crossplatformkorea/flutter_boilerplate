import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CollapsibleTabScroll extends HookWidget {
  const CollapsibleTabScroll({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
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
            body: TabBarView(
              children: [
                GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 20,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 9 / 14,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.amber,
                      child: Center(
                        child: Text('${index + 1}'),
                      ),
                    );
                  },
                ),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return ListTile(
                      tileColor: Colors.green,
                      title: Text(
                        'Item ${index + 1}',
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
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
