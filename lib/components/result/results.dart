import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:our_e_college_app/components/result/resultitem.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Future getresult() async {
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
        return await FirebaseFirestore.instance
            .collection('Batch')
            .doc(student["batch"])
            .collection('Branch')
            .doc(student["branch"])
            .collection('Section')
            .doc(student["section"])
            .collection("Result")
            .get()
            .then((snapshot) async {
          return snapshot;
        });
      } else {
        print('Document does not exist on the student database\n\n\n');
      }
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
          title: Text("Results"),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top:12.0),
            child: FutureBuilder(
              future: getresult(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    final List items = snapshot.data.docs;
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext ctxt, int i) {
                        return ResultItem(
                          subject: items[i]["subject"],
                          uploadDate: items[i]["uploadDate"],
                          marks: items[i]["marks"],
                          uri: items[i]["uri"],
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
