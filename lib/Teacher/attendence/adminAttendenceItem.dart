import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminAttendenceItem extends StatefulWidget {
  String name;
  final attend;
  // String submissionTime;
  final total;

  AdminAttendenceItem(
      {this.name,
        this.attend,
      this.total});

  @override
  _AdminAttendenceItemState createState() => _AdminAttendenceItemState();
}

class _AdminAttendenceItemState extends State<AdminAttendenceItem> {

  @override
  Widget build(BuildContext context) {
    return ListTile(                //return new ListTile(
              onTap: null,
              tileColor: Colors.white,
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text("A",style: TextStyle(
                  color: Colors.white
                ),),
              ),
              title: Row(
                  children: <Widget>[
                    Expanded(child: Text(widget.name)),
                    Expanded(child: Text(widget.attend.toString())),
                    Expanded(child: Text(widget.total.toString()))
                  ]
              )
    );
  }
}
