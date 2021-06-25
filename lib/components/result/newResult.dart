import 'dart:convert';
import 'dart:io';

import 'package:date_field/date_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:our_e_college_app/components/classroom/classroom_helper.dart';

class NewResult extends StatefulWidget {
  final classDetails;
  NewResult({this.classDetails});

  @override
  _NewResultState createState() => _NewResultState();
}

class _NewResultState extends State<NewResult> {
  final Title = TextEditingController();
  String ResultUri;

  Future getResult() async {
    FilePickerResult pickedFile = await FilePicker.platform.pickFiles();
    setState(() {
      ResultUri = pickedFile.files.single.path;
    });
  }
  uploadResult() async {
    try {
      await FirebaseStorage.instance
          .ref('Temporary-Storage')
          .putFile(File(ResultUri))
          .then((snapshot) async {
              var uri = await snapshot.ref.getDownloadURL();
              var url = Uri.parse('http://localhost:5000/api/uploadResult');
              Map body = {
                "classId":widget.classDetails["_id"],
                "result":{
                  "title":Title.text,
                  "uri":uri,
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
        title: Text("Result"),
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
                    OutlinedButton(
                        onPressed: () {
                          getResult();
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
                          uploadResult();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: (ClassRoomHelper.loading==true)?
                          CircularProgressIndicator(
                            color: Colors.white,
                          ):Row(
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
