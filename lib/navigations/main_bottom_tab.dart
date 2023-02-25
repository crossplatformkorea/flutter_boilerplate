import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_seoul/screens/edit_profile.dart';
import 'package:flutter_seoul/screens/home.dart';
import 'package:flutter_seoul/screens/permission.dart';

import '../utils/colors.dart';

enum ScreenType { social, generalMeetings }

class MainBottomTab extends HookWidget {
  const MainBottomTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentIndex = useState(0);

    return Scaffold(
      body: [
        const Home(),
        const Permission(),
        const EditProfile(),
      ].elementAt(currentIndex.value),
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
        onTap: (index) => currentIndex.value = index,
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
