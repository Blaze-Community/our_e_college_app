import 'package:flutter/material.dart';
import 'package:our_e_college_app/app.dart';
import 'package:our_e_college_app/components/assignment/assignment.dart';
import 'package:our_e_college_app/components/classroom/data/classworks.dart';
import 'package:our_e_college_app/components/result/results.dart';

class ClassWork extends StatefulWidget {
  final classDetails;
  ClassWork({this.classDetails});

  @override
  _ClassWorkState createState() => _ClassWorkState();
}

class _ClassWorkState extends State<ClassWork> {
  @override
  Widget build(BuildContext context) {
    final tabs = [
      Assignment(classDetails: widget.classDetails),
      Result(classDetails: widget.classDetails)
    ];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Classwork",
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
                  text: "Assignment",
                ),
                Tab(
                  text: "Result",
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