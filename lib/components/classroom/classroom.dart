import 'package:flutter/material.dart';

class ClassRoom extends StatefulWidget {
  @override
  _ClassRoomState createState() => _ClassRoomState();
}

class _ClassRoomState extends State<ClassRoom>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("ClassRoom"),
        ),
        body:  Center(
          child: ElevatedButton(

            onPressed: () {

              Navigator.pop(context);
            },
            child: Text('Coming Soon!!'),
          ),

        ));
  }

}