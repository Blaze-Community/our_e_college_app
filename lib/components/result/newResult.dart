import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:our_e_college_app/components/classroom/classroom_helper.dart';
import 'package:uuid/uuid.dart';

import '../../global-helper.dart';

class NewResult extends StatefulWidget {
  final classDetails;
  NewResult({this.classDetails});

  @override
  _NewResultState createState() => _NewResultState();
}

class _NewResultState extends State<NewResult> {
  final Title = TextEditingController();
  String ResultUri;
  var loading = false;

  Future getResult() async {
    FilePickerResult pickedFile = await FilePicker.platform.pickFiles();
    setState(() {
      ResultUri = pickedFile.files.single.path;
    });
  }
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
          .putFile(File(ResultUri))
          .then((snapshot) async {
        var uri = await snapshot.ref.getDownloadURL();
        final storage = new FlutterSecureStorage();
        final accessToken = await storage.read(key: "accessToken");
        //   final accessToken = GlobalHelper.accessToken;
        var url = 'https://college-app-backend.herokuapp.com/api/uploadResult';
        Map body = {
          "classId":widget.classDetails["_id"],
          "result":{
            "title":Title.text,
            "uri":uri,
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
            return json.decode(response.body);
          }
          else{
            print(json.decode(response.body));
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

  uploadResult() async {
    var responseJson = await checkAccessToken();
    if (responseJson['msg'] == "Access token expired") {
      await refresh();
      responseJson = await checkAccessToken();
    }
    if (responseJson['success'] == true) {
      setState(() {
        GlobalHelper.loading = true;
      });
      Navigator.pop(context);
      ClassRoomHelper.shared.fetchClassInfo(widget.classDetails["_id"]);
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
                            loading = true;
                          });
                          uploadResult();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: (loading == true)?
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
