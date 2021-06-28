import 'package:flutter/material.dart';
import 'package:our_e_college_app/components/classroom/screens/classroom/people_tab.dart';

import 'classroom/classwork_tab.dart';
import 'classroom/stream_tab.dart';

class ClassRoomPage extends StatefulWidget {
  AssetImage bannerImg;
  String className;
  final classDetails;
  //Color uiColor;

  ClassRoomPage({this.className, this.bannerImg,this.classDetails});

  @override
  _ClassRoomPageState createState() => _ClassRoomPageState();
}

class _ClassRoomPageState extends State<ClassRoomPage> {

  @override
  Widget build(BuildContext context) {
    String className = widget.className;
    AssetImage bannerImg = widget.bannerImg;
    final classDetails = widget.classDetails;
    final tabs = [
      StreamTab(
        bannerImg: bannerImg,
        className: className,
      ),
      ClassWork(classDetails: classDetails),
      PeopleTab(classDetails: classDetails)
    ];
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Classroom",
          style: TextStyle(
            color: Colors.deepOrange
          ),),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.deepOrange,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          bottom: TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.deepOrange,
            tabs: [
              Tab(
                icon: Icon(Icons.chat),
                text: "Stream",
              ),
              Tab(
                icon: Icon(Icons.book),
                text: "Classwork",
              ),
              Tab(
                icon: Icon(Icons.people),
                text: "People",
              ),
            ],
          ),
        ),
        // backgroundColor: Colors.deepPurple,
        body: TabBarView(
        children:tabs,)
      ),
    );
  }
}
