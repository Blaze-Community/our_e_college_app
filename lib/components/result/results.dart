import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:our_e_college_app/components/assignment/newAssignment.dart';
import 'package:our_e_college_app/components/result/resultitem.dart';
import 'package:our_e_college_app/global.dart' as Global;

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Future getresult() async {
    var uid = FirebaseAuth.instance.currentUser.uid;
    var student;
    return await FirebaseFirestore.instance
        .collection('Users')
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
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top:12.0),
            child: Stack(
              children: [
                FutureBuilder(
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
                if(Global.user == "Teacher")Padding(
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
                                      NewAssignment()));
                        },
                        label: Text('Add Result'),
                        icon: Icon(Icons.add),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
