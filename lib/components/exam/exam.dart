import 'package:flutter/material.dart';

class Exam extends StatefulWidget {
  @override
  _ExamState createState() => _ExamState();
}

class _ExamState extends State<Exam>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Exam"),
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