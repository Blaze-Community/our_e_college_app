import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:our_e_college_app/components/classroom/classroom_helper.dart';
import 'package:our_e_college_app/global-helper.dart';
import 'package:our_e_college_app/components/classroom/data/comments.dart';

class CommentComposer extends StatefulWidget {
  final String id;
  final String message;
  final String date;
  final String classId;
  CommentComposer({this.classId, this.id, this.date, this.message});
  
  @override
  _CommentComposerState createState() => _CommentComposerState();
}

class _CommentComposerState extends State<CommentComposer> {

  Future refresh() async {
    String url = 'https://college-app-backend-production.up.railway.app/api/refresh';
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
        final storage = new FlutterSecureStorage();
        final accessToken = await storage.read(key: "accessToken");
        //final accessToken = GlobalHelper.accessToken;

        var url = 'https://college-app-backend-production.up.railway.app/api/deleteMessage';
        Map body = {"classId": widget.classId, "msgId": widget.id};
        final response = await http.delete(Uri.parse(url),
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
  deleteMessage() async {
    var responseJson = await checkAccessToken();
    if (responseJson['msg'] == "Access token expired") {
      await refresh();
      responseJson = await checkAccessToken();
    }
    if (responseJson['success'] == true) {
      ClassRoomHelper.shared.fetchClassInfo(widget.classId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        padding: EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.deepOrange),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Dated : ${widget.date}",
                  style: TextStyle(color: Colors.black),
                )),
                if (GlobalHelper.userRole != "student")
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        GlobalHelper.loading = true;
                      });
                      deleteMessage();
                    },
                  )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Message - ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
                width: MediaQuery.of(context).size.width - 40,
                margin: EdgeInsets.only(bottom: 10),
                child: Text(widget.message)),
          ],
        ));
  }
}
