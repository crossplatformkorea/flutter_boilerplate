import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/screens/search_user_screen.dart';
import 'package:flutter_boilerplate/screens/temp_screen.dart';

class MainBottomTab extends StatefulWidget {
  const MainBottomTab({Key? key}) : super(key: key);

  @override
  State<MainBottomTab> createState() => _MainBottomTabState();
}

class _MainBottomTabState extends State<MainBottomTab> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const [
        TempScreen(),
        SearchUserScreen(),
      ].elementAt(_index),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (int index) => setState(() => _index = index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
              size: 20,
            ),
            label: "Temp",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.rocket_launch,
              size: 20,
            ),
            label: "Temp",
          ),
        ],
      ),
    );
  }
}
