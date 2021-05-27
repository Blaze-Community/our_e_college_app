import 'dart:io';
import 'package:flutter/material.dart';
import 'package:our_e_college_app/profilesection/profilelistitem.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File image;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            margin: EdgeInsets.only(top: 30),
            child: Stack(
              children: [
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  child: CircleAvatar(
                    radius: 50,
                    foregroundImage: image == null
                        ? AssetImage('splash.jpg')
                        : FileImage(image),
                  ),
                  onTap: () {
                    getImage();
                  },
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      heightFactor: 15,
                      widthFactor: 15,
                      child: Icon(
                        Icons.person_search,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Harsh Shrivastava',
          ),
          SizedBox(height: 5),
          Text(
            'BT19CSE006@iitn.com',
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                ProfileListItem(
                  icon: Icons.book,
                  text: 'Backlogs',
                  onPressed: () {},
                ),
                ProfileListItem(
                  icon: Icons.calendar_today_outlined,
                  text: 'Acadmic Calendar',
                  onPressed: () {},
                ),
                ProfileListItem(
                  icon: Icons.settings,
                  text: 'About',
                  onPressed: () {},
                ),
                ProfileListItem(
                  icon: Icons.star_rate,
                  text: 'Report',
                  onPressed: () {},
                ),
                ProfileListItem(
                  icon: Icons.logout,
                  text: 'Logout',
                  onPressed: () {},
                  hasNavigation: false,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
