import 'dart:io';
import 'package:flutter/material.dart';
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
                  height: 20,
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
                ),
                ProfileListItem(
                  icon: Icons.calendar_today_outlined,
                  text: 'Acadmic Calendar',
                ),
                ProfileListItem(
                  icon: Icons.settings,
                  text: 'Settings',
                ),
                ProfileListItem(
                  icon: Icons.star_rate,
                  text: 'Rate us',
                ),
                ProfileListItem(
                  icon: Icons.logout,
                  text: 'Logout',
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

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;

  const ProfileListItem({
    Key key,
    this.icon,
    this.text,
    this.hasNavigation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(
        horizontal: 40,
      ).copyWith(
        bottom: 20,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            this.icon,
            size: 25,
          ),
          SizedBox(width: 15),
          Text(
            this.text,
          ),
          Spacer(),
          if (this.hasNavigation)
            Icon(
              Icons.arrow_forward,
              size: 25,
            ),
        ],
      ),
    );
  }
}