import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:our_e_college_app/components/assignment/assignmentItem.dart';

class Assignment extends StatefulWidget {
  @override
  _AssignmentState createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {
  Future getassignment() async {
    User user = FirebaseAuth.instance.currentUser;
    var uid = user.uid;
    var student;
    await FirebaseFirestore.instance
        .collection('Students')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        student = documentSnapshot.data();
      } else {
        print('Document does not exist on the student database\n\n\n');
      }
    });
    return await FirebaseFirestore.instance
        .collection('Batch')
        .doc(student["batch"])
        .collection('Branch')
        .doc(student["branch"])
        .collection('Section')
        .doc(student["section"])
        .collection("assignment")
        .get()
        .then((snapshot) async {
      return snapshot;
    });
  }

  @override
  void initState() {
    super.initState();
    // getassignment();
    // print(items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Assignment"),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: FutureBuilder(
            future: getassignment(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  final List items = snapshot.data.docs;
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext ctxt, int i) {
                      return AssignmentList(
                        subject: items[i]["subject"],
                        submissionDate: items[i]["submissionDate"],
                        title: items[i]["title"],
                        uploadDate: items[i]["uploadDate"],
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
        ));
  }
}
