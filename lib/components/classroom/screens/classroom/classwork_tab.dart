import 'package:flutter/material.dart';
import 'package:our_e_college_app/components/assignment/assignment.dart';
import 'package:our_e_college_app/components/classroom/data/classworks.dart';
import 'package:our_e_college_app/components/result/results.dart';

class ClassWork extends StatefulWidget {
  @override
  _ClassWorkState createState() => _ClassWorkState();
}

class _ClassWorkState extends State<ClassWork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedTabBar(),
    );
  }
}

class NestedTabBar extends StatefulWidget {
  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}
class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  TabController _nestedTabController;
  @override
  void initState() {
    super.initState();
    _nestedTabController = new TabController(length: 2, vsync: this);
  }
  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TabBar(
          controller: _nestedTabController,
          indicatorColor: Colors.orange,
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.black54,
          labelPadding: EdgeInsets.symmetric(horizontal:10),
          tabs: <Widget>[
            Tab(
              text: "Assignment",
            ),
            Tab(
              text: "Result",
            ),

          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _nestedTabController,
            children: <Widget>[
              Assignment(),
              Result()

            ],
          ),
        )
      ],
    );
  }
}
