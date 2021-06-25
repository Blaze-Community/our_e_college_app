import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  String name;
  String uri;

  Profile({this.name, this.uri,});

  @override
  _ProfileState createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          SizedBox(width: 15),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: (widget.uri.length>0)?
            NetworkImage(widget.uri):
            AssetImage("assets/splash.jpg")
          ),
          SizedBox(
            width: 10,
          ),
          Text(widget.name)
        ],
      ),
    );
  }
}
