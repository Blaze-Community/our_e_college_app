import 'package:flutter/material.dart';
import 'package:our_e_college_app/app.dart';
import 'screens/class_home_page.dart';

void main() => runApp(GoogleClassroomClone());

class GoogleClassroomClone extends StatefulWidget {
  @override
  _GoogleClassroomCloneState createState() => _GoogleClassroomCloneState();
}

class _GoogleClassroomCloneState extends State<GoogleClassroomClone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Classroom"),
      ),
      body: ClassRoomHomePage(),
    );
  }
}
