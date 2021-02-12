import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isDrawerOpen ? 30 : 0.0),
          color: Colors.grey[200]),
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor),
      duration: Duration(milliseconds: 250),
      child: Column(children: [
        SizedBox(
          height: 80,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 80,
            ),
            IconButton(
                icon: Icon(
                  Icons.menu,
                  size: 40,
                ),
                onPressed: () {
                  if (isDrawerOpen == false) {
                    setState(() {
                      xOffset = 230;
                      yOffset = 160;
                      scaleFactor = 0.6;
                      isDrawerOpen = true;
                    });
                  } else {
                    setState(() {
                      xOffset = 0;
                      yOffset = 0;
                      scaleFactor = 1;
                      isDrawerOpen = false;
                    });
                  }
                })
          ],
        ),
      ]),
    );
    ;
  }
}
