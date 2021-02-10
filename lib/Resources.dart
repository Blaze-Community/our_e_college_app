import 'package:flutter/material.dart';
import 'package:our_e_college_app/utils/drawer.dart';
import 'package:our_e_college_app/utils/homepage.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class Resources extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [DrawerApp(), HomeScreen()],
      ),
    );
  }
}
