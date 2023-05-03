import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_seoul/utils/router_config.dart';
import 'package:go_router/go_router.dart';

import '../utils/colors.dart';

enum ScreenType { social, generalMeetings }

class MainBottomTab extends HookWidget {
  const MainBottomTab({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var currentIndex = useState(0);

    void tap(BuildContext context, int index) {
      if (index == currentIndex.value) {
        // If the tab hasn't changed, do nothing
        return;
      }
      currentIndex.value = index;
      if (index == 0) {
        // Note: this won't remember the previous state of the route
        // More info here:
        // https://github.com/flutter/flutter/issues/99124
        context.goNamed(GoRoutes.home.name);
      } else if (index == 1) {
        context.goNamed(GoRoutes.permission.name);
      } else if (index == 2) {
        context.goNamed(GoRoutes.editProfile.name);
      }
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex.value,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedItemColor: AppColors.role.brand,
        unselectedItemColor: AppColors.text.placeholder,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        iconSize: 24,
        onTap: (index) => tap(context, index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
            tooltip: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock),
            label: '권한',
            tooltip: '권한',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '프로필',
            tooltip: '프로필',
          ),
        ],
      ),
    );
  }
}
