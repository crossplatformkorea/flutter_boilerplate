import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_seoul/utils/colors.dart';

class TabScroll extends HookWidget {
  const TabScroll({super.key});

  @override
  Widget build(BuildContext context) {
    var tabController = useTabController(initialLength: 3);
    return Scaffold(
      appBar: AppBar(
          title: const Text('tab scroll'),
          bottom: TabBar(
            controller: tabController,
            labelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: TextStyle(color: AppColors.role.primary),
            unselectedLabelStyle: TextStyle(color: AppColors.text.placeholder),
            tabs: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Tab(
                  text: 'tab1',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Tab(
                  text: 'tab2',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Tab(
                  text: 'tab3',
                ),
              ),
            ],
          )),
      body: TabBarView(
        controller: tabController,
        children: const [
          Icon(Icons.flight, size: 350),
          Icon(Icons.directions_transit, size: 350),
          Icon(Icons.directions_car, size: 350),
        ],
      ),
    );
  }
}
