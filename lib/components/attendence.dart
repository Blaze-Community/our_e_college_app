import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:our_e_college_app/utils/attendenceItem.dart';

class Attendence extends StatefulWidget {
  @override
  _Attendence createState() => _Attendence();

}
class _Attendence extends State<Attendence> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendence"),
      ),
      body: ListView(
        children: [
          AttendenceItem(subject:"Data Structure",attend: 4,totalClasses: 14,primaryColor: Color(0xFF2633C5),secondaryColor: HexColor("#8A98E8")),
          AttendenceItem(subject:"English",attend: 6,totalClasses: 10,primaryColor: Color(0xFF1B5E20),secondaryColor: HexColor("8ae89e")),
          AttendenceItem(subject:"Hindi",attend: 6,totalClasses: 10,primaryColor: Color(0xFFB71C1C),secondaryColor: HexColor("#e88a8a")),
          AttendenceItem(subject:"Maths",attend: 10,totalClasses: 10,primaryColor: Color(0xFF880E4F),secondaryColor: HexColor("#e88aa8")),
          AttendenceItem(subject:"Science",attend: 8,totalClasses: 10,primaryColor: Color(0xFFE64A19),secondaryColor: HexColor("#e8a68a")),
          AttendenceItem(subject:"OOP",attend: 4,totalClasses: 10,primaryColor: Color(0xFFFFD600),secondaryColor: HexColor("#f5f59f")),

        ],
      )
    );
  }
}