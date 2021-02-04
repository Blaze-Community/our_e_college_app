import 'package:flutter/material.dart';

class DrawerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Draco'),
            accountEmail: Text('klpd@gmail.com'),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(color: Colors.red),
          ),
          //Body
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Profile'),
              leading: Icon(Icons.person),
            ),
          ),

          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Reports'),
              leading: Icon(Icons.assessment),
            ),
          ),

          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Assigmnets'),
              leading: Icon(Icons.assignment),
            ),
          ),

          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Attendance'),
              leading: Icon(Icons.bar_chart_rounded),
            ),
          ),

          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Notice'),
              leading: Icon(Icons.content_paste_sharp),
            ),
          ),

          Divider(),
          Expanded(
              child: Container(
            color: Colors.blueGrey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text('Settings'),
                    leading: Icon(Icons.settings),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text('Help and Feedback'),
                    leading: Icon(Icons.help, color: Colors.green),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
