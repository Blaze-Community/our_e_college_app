import 'package:flutter/material.dart';

class Assignment extends StatefulWidget {
  @override
  _AssignmentState createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            padding: EdgeInsets.only(top: 15),
            children: [
              AssignmentBox(
                subject: "English",
                title: "Essay on classes",
                submissionDate: "24-07-21",
              ),
              AssignmentBox(
                subject: "Maths",
                title: "Solve lesson 2",
                submissionDate: "24-07-21",
              ),
              AssignmentBox(
                subject: "Hindi",
                title: "Read the book of ramayan",
                submissionDate: "24-07-21",
              ),
            ],
          ),
        ));
  }
}

class AssignmentBox extends StatelessWidget {
  final String subject;
  final String title;
  final String submissionDate;

  AssignmentBox({this.subject, this.title, this.submissionDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 5.0,
              spreadRadius: 2.0,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 10,
          ),
          Container(
              width: 90,
              height: 100,
              child: Text(
                subject,
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              )),
          VerticalDivider(
            thickness: 1,
            color: Colors.grey,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                "Submisson Date - $submissionDate",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
