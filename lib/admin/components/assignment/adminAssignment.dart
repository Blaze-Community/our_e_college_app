import 'package:flutter/material.dart';
import 'package:our_e_college_app/admin/components/assignment/adminAssignmentItem.dart';
import 'package:our_e_college_app/admin/components/assignment/newAssignment.dart';


class AdminAssignment extends StatefulWidget {
  @override
  _AdminAssignmentState createState() => _AdminAssignmentState();
}

class _AdminAssignmentState extends State<AdminAssignment> {
  final List items = [
    AdminAssignmentItem(
        subject: "DSA",
        title: "Merge Sort",
        submissionDate: "28 May 2021",
        uploadDate: "21 May 2021",
        hasSubmitted: false),
    AdminAssignmentItem(
        subject: "DSA",
        title: "Merge Sort",
        submissionDate: "27 May 2021",
        uploadDate: "21 May 2021",
        hasSubmitted: false),
    AdminAssignmentItem(
        subject: "DSA",
        title: "Merge Sort",
        submissionDate: "26 May 2021",
        uploadDate: "21 May 2021",
        hasSubmitted: true),
    AdminAssignmentItem(
        subject: "DSA",
        title: "Merge Sort",
        submissionDate: "25 May 2021",
        uploadDate: "21 May 2021",
        hasSubmitted: false),
    AdminAssignmentItem(
        subject: "DSA",
        title: "Merge Sort",
        submissionDate: "24 May 2021",
        uploadDate: "21 May 2021",
        hasSubmitted: true),
    AdminAssignmentItem(
        subject: "DSA",
        title: "Merge Sort",
        submissionDate: "23 May 2021",
        uploadDate: "21 May 2021",
        hasSubmitted: true),
  ];

  @override
  Widget build(BuildContext context) {
    // items.sort((a, b) => a.submissionDate.compareTo(b.submissionDate));
    return Scaffold(
        appBar: AppBar(
          title: Text("Assignment"),
        ),
        body: Stack(
          
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: ListView(
                  padding: EdgeInsets.only(top: 15),
                  children: List.generate(items.length, (index) => items[index])),
            ),
            Padding(
              // bottom: 10,
              padding: EdgeInsets.only(bottom: 10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => NewAssignment()));
                  },
                  label: Text('Add New Assignment'),
                  icon: Icon(Icons.add),
                ),

              )
            )
          ],
        )
        );
  }
}
