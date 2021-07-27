import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:date_field/date_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:our_e_college_app/components/classroom/classroom_helper.dart';
import 'package:our_e_college_app/global-helper.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:uuid/uuid.dart';

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
  var loading = false;
  Future refresh() async {
    String url = 'https://college-app-backend.herokuapp.com/api/refresh';
    final storage = new FlutterSecureStorage();
    final refreshToken = await storage.read(key: "refreshToken");
    //final refreshToken = GlobalHelper.refreshToken;
    final body = json.encode({"token": refreshToken});
    final response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: body);
    if(response.statusCode == 200){
      final responseJson = json.decode(response.body);
      if (responseJson['msg'] == "Refresh token expired, Please Login again!") {
        Fluttertoast.showToast(
            msg: "Refresh token expired, Please Login again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        // refresh token expired, show dailogue that says user to login again.
        print("Refresh token expired, please login again");
      }
      final accessToken = responseJson['accessToken'];
      await storage.write(key: "accessToken", value: accessToken);
      // GlobalHelper.accessToken = accessToken;
    }
    else{
      print(json.decode(response.body)["msg"]);
    }
  }

  Future<dynamic> checkAccessToken() async {
    try {
      var uuid = Uuid().v1();
      return await FirebaseStorage.instance
          .ref('Temporary-Storage/${uuid}')
          .putFile(File(AssignmentUri))
          .then((snapshot) async {
        var uri = await snapshot.ref.getDownloadURL();
        final storage = new FlutterSecureStorage();
        final accessToken = await storage.read(key: "accessToken");
         //final accessToken = GlobalHelper.accessToken;

        var url = 'https://college-app-backend.herokuapp.com/api/uploadAssignment';
        Map body = {
          "classId": widget.classDetails["_id"],
          "assignment":{
            "title":Title.text,
            "uri":uri,
            "submissionDate":SubmissionDate

          }
        };
        final response = await http.post(Uri.parse(url),
            headers: {
              "Authorization": "Bearer $accessToken",
              "Content-Type": "application/json",
            },
            body: json.encode(body));
        try{
          if(response.statusCode == 200){
            Fluttertoast.showToast(
                msg: "Success!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
            return json.decode(response.body);
          }
          else{
            Fluttertoast.showToast(
                msg: "ERROR!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
            print(json.decode(response.body)["msg"]);
          }
        }
        catch(err){
          print(err);
        }
      });
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print(e.code);
    }
  }

  Future getAssignment() async {
    FilePickerResult pickedFile = await FilePicker.platform.pickFiles();
    setState(() {
      AssignmentUri = pickedFile.files.single.path;
    });
  }
  uploadAssignment() async {
    var responseJson = await checkAccessToken();
    if (responseJson['msg'] == "Access token expired") {
      await refresh();
      responseJson = await checkAccessToken();
    }
    if (responseJson['success'] == true) {
      Navigator.pop(context);
      ClassRoomHelper.shared.fetchClassInfo(widget.classDetails["_id"]);
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
                        loading = true;
                        GlobalHelper.loading = true;
                      });
                      uploadAssignment();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: (loading ==true)?
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
