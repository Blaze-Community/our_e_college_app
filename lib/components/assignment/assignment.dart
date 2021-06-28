import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:our_e_college_app/components/assignment/newAssignment.dart';
import 'package:our_e_college_app/components/assignment/assignmentItem.dart';
import 'package:our_e_college_app/components/classroom/classroom_helper.dart';
import 'package:our_e_college_app/components/classroom/create_join/create_class.dart';
import 'package:our_e_college_app/global-helper.dart';
import 'package:simple_moment/simple_moment.dart';

class Assignment extends StatefulWidget {
  final classDetails;
  Assignment({this.classDetails});

  @override
  _AssignmentState createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {

  @override
  void initState() {
    // TODO: implement initState
    ClassRoomHelper.shared.fetchClassInfo(widget.classDetails["_id"]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Assignment"),
        // ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top:12.0),
            child: Stack(
              children: [
                StreamBuilder(
                  stream: ClassRoomStreamControllerHelper.shared.classInfostream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active && GlobalHelper.loading == false) {
                      if (snapshot.hasData) {
                        final List items = snapshot.data["assignments"];
                        return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext ctxt, int i) {
                            return AssignmentList(
                              submissionDate: items[i]["submissionDate"],
                              title: items[i]["title"],
                              uploadDate: Moment.parse(items[i]["createdAt"]).format('dd-MM-yyyy'),
                              uri:items[i]["uri"]
                            );
                          },
                        );
                      }
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                if( GlobalHelper.userRole == "teacher")Padding(
                  // bottom: 10,
                    padding: EdgeInsets.only(bottom: 10),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      NewAssignment(classDetails: widget.classDetails)));
                        },
                        label: Text('Add New Assignment'),
                        icon: Icon(Icons.add),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
