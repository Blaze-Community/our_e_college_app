import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../../global-helper.dart';
import '../classroom_helper.dart';

class joinclass extends StatefulWidget {
  @override
  _joinclass createState() => _joinclass();
}
class _joinclass extends State<joinclass> {
  final EnrolKey = TextEditingController();
  var loading = false;
  Future refresh() async {
    String url = 'https://college-app-backend.herokuapp.com/api/refresh';
    final storage = new FlutterSecureStorage();
    final refreshToken = await storage.read(key: "refreshToken");
    // final refreshToken = GlobalHelper.refreshToken;
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

  Future<dynamic> checkAccessToken(enrolkey) async {

    String url = 'https://college-app-backend.herokuapp.com/api/joinClass';
    final storage = new FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");
    //final accessToken = GlobalHelper.accessToken;

    Map body = {
      "enrolKey":enrolkey,
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
  }

  joinClass(enrolkey) async {

    var responseJson = await checkAccessToken(enrolkey);
    if (responseJson['msg'] == "Access token expired") {
      await refresh();
      responseJson = await checkAccessToken(enrolkey);
    }

    if (responseJson['success'] == true) {
      Navigator.pop(context);
      ClassRoomHelper.shared.fetchClassRoomlist();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join Class"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0),
          child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.deepPurple)),
              child: TextField(
                controller: EnrolKey,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Key",
                ),
              ),
            ),
            SizedBox(height:45.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  loading = true;
                  GlobalHelper.loading = true;
                });
                joinClass(EnrolKey.text);
              },
              child: Padding(
                padding: EdgeInsets.all(15),
                child: (loading == true)?
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
                      "Join",
                      style: TextStyle(
                        fontSize: 15,
                      ),
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

