import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:our_e_college_app/components/classroom/classroom_helper.dart';

import '../../../global-helper.dart';

class createclass extends StatefulWidget {
  @override
  _createclass createState() => _createclass();
}
class _createclass extends State<createclass> {
  final Subject = TextEditingController();
  final Batch = TextEditingController();
  final Section = TextEditingController();
  final Branch = TextEditingController();
  var loading = false;
  Future refresh() async {
    String url = 'https://college-app-backend.herokuapp.com/refresh';
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
      //GlobalHelper.accessToken = accessToken;
    }
    else{
      print(json.decode(response.body)["msg"]);
    }
  }

  Future<dynamic> checkAccessToken() async {

    String url = 'https://college-app-backend.herokuapp.com/api/createClass';
    final storage = new FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");
     //final accessToken = GlobalHelper.accessToken;

    Map body =  {
      "clas": {
        "branch":Branch.text,
        "section": Section.text,
        "subject": Subject.text,
        "batch": Batch.text,
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
  }

  createClass() async {
    var responseJson = await checkAccessToken();
    if (responseJson['msg'] == "Access token expired") {
      await refresh();
      responseJson = await checkAccessToken();
    }

    print(responseJson);
    if (responseJson['success'] == true) {
      Navigator.pop(context);
      ClassRoomHelper.shared.fetchClassRoomlist();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Class"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.deepPurple)),
                child: TextField(
                  controller: Subject,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Subject",
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Container(
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.deepPurple)),
                child: TextField(
                  controller: Batch,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Batch",
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Container(
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.deepPurple)),
                child: TextField(
                  controller: Section,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Section",
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Container(
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.deepPurple)),
                child: TextField(
                  controller: Branch,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Branch",
                  ),
                ),
              ),
              SizedBox(height:45.0),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      loading  = true;
                      GlobalHelper.loading = true;
                    });
                    createClass();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child:  (loading ==true)?
                    CircularProgressIndicator(
                      color: Colors.white,
                    ):
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.publish, size: 25),
                        SizedBox(width: 10),
                        Text("Create",
                              style: TextStyle(fontSize: 14),
                            ),
                      ],
                    ),
                  ),),
            ],
          ),
        ),
      ),
    );
  }
}

