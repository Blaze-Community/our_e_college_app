import 'dart:convert';
import 'dart:io';

import 'package:date_field/date_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:our_e_college_app/components/classroom/classroom_helper.dart';
import 'package:simple_moment/simple_moment.dart';

class NewAssignment extends StatefulWidget {
  final classDetails;
  NewAssignment({this.classDetails});

  @override
  _NewAssignmentState createState() => _NewAssignmentState();
}

class _NewAssignmentState extends State<NewAssignment> {
  final Title = TextEditingController();
  String SubmissionDate ;
  String AssignmentUri;

  Future getAssignment() async {
    FilePickerResult pickedFile = await FilePicker.platform.pickFiles();
    setState(() {
      AssignmentUri = pickedFile.files.single.path;
    });
    //print("upload file ${await uploadFile(pickedFile.path)}");
    //uploadFile(pickedFile.path);
  }
  uploadAssignment() async {
    try {
      await FirebaseStorage.instance
          .ref('Temporary-Storage')
          .putFile(File(AssignmentUri))
          .then((snapshot) async {
              var uri = await snapshot.ref.getDownloadURL();
              var url = Uri.parse('http://localhost:5000/api/uploadAssignment');
              Map body = {
                "classId": widget.classDetails["_id"],
                "assignment":{
                  "title":Title.text,
                  "uri":uri,
                  "submissionDate":SubmissionDate

                }
              };
              await http.post(url,body:json.encode(body),headers:{'content-type':'application/json'}).then((response){
                Navigator.pop(context);
                ClassRoomHelper.shared.fetchClassInfo(widget.classDetails["_id"]);
              });
      });
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print(e.code);
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Assignment"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 45.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
                child: Column(
              children: [
                Text('Details',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16.0,
                        color: Colors.grey)),
                SizedBox(height: 5),
                Container(height: 1.0, color: Colors.deepOrange, width: 50.0),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.deepPurple)),
                  child: TextField(
                    controller: Title,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Title",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.deepPurple)),
                  child: DateTimeFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black45),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.event_note),
                      labelText: 'Submission Date',
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (e) =>
                        (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                    onDateSelected: (DateTime value) {
                      setState(() {
                        SubmissionDate = Moment.parse(value.toString()).format('dd-MM-yyyy');
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                OutlinedButton(
                    onPressed: () {
                      getAssignment();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.upload, size: 25),
                          SizedBox(width: 10),
                          Text(
                            "Upload PDF",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(height: 40),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        ClassRoomHelper.loading = true;
                      });
                      uploadAssignment();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: (ClassRoomHelper.loading==true)?
                      CircularProgressIndicator(
                        color: Colors.white,
                      ):
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.publish, size: 25),
                          SizedBox(width: 10),
                          Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(height: 30)
              ],
            )),
          ),
        ),
      ),
    );
  }
}
