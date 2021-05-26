import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../app.dart';
import 'package:flutter/material.dart';

import 'bottomBarTabItem.dart';
import 'package:our_e_college_app/utils/Theme.dart' as AppTheme;

class BottomNavigation extends StatelessWidget {
  BottomNavigation({
    this.onSelectTab,
    this.tabs,
  });
  final ValueChanged<int> onSelectTab;
  final List<TabItem> tabs;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: AppTheme.Colors.black,
      height: 63,
      items: tabs
          .map(
            (e) => Icon(e.icon, size: 30),
          )
          .toList(),
      onTap: (index) => onSelectTab(
        index,
      ),
    );
  }
}
