import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:our_e_college_app/components/assignment/assignmentItem.dart';

class Assignment extends StatefulWidget {
  @override
  _AssignmentState createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {

  getassignment() async {
    User user = FirebaseAuth.instance.currentUser;
    var uid = user.uid;
    var student;
    return await FirebaseFirestore.instance
        .collection('Students')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        student = documentSnapshot.data();
        print(student);
        return await FirebaseFirestore.instance
            .collection('Batch')
            .doc(student["batch"])
            .collection('Branch')
            .doc(student["branch"])
            .collection('Section')
            .doc(student["section"])
            .collection("Assignment")
            .get()
            .then((snapshot){
             return snapshot;
        });
      } else {
        print('Document does not exist on the student database\n\n\n');
      }
    });
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
          child: Padding(
            padding: const EdgeInsets.only(top:12.0),
            child: FutureBuilder(
              future: getassignment(),
              builder: (context, snapshot) {
                print("snapshot ass $snapshot");
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
          ),
        ));
  }
}
