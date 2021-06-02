import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminResultItem extends StatefulWidget {
  String name;
  final marks;
  // String submissionTime;
  final total;

  AdminResultItem(
      {this.name,
        this.marks,
      this.total});

  @override
  _AdminResultItemState createState() => _AdminResultItemState();
}

class _AdminResultItemState extends State<AdminResultItem> {

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
                    Expanded(child: Text(widget.marks.toString())),
                    Expanded(child: Text(widget.total.toString()))
                  ]
              )
    );
  }
}
