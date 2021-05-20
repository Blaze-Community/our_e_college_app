import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:our_e_college_app/utils/Theme.dart'as AppTheme;
import 'package:our_e_college_app/utils/drawer.dart';
import 'package:our_e_college_app/utils/homepage.dart';

//State class
int _page = 0;
GlobalKey _bottomNavigationKey = GlobalKey();

class Resources extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: AppTheme.Colors.black,
        height: 63,
        items: <Widget>[
          Icon(Icons.list, size: 30),
          Icon(Icons.compare_arrows, size: 30),
          Icon(Icons.add, size: 30),
          Icon(Icons.home, size: 30),
          Icon(Icons.person_rounded, size: 30),
        ],
        onTap: (index) {
          //Handle button tap
        },
      ),
      body: Stack(
        children: [DrawerApp(), HomeScreen()],
      ),
      
    );
  }
}
