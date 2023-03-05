import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:our_e_college_app/components/assignment/newAssignment.dart';
import 'package:our_e_college_app/components/classroom/classroom_helper.dart';
import 'package:our_e_college_app/components/classroom/create_join/create_class.dart';
import 'package:our_e_college_app/global-helper.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Assignment extends StatefulWidget {
  final classDetails;
  Assignment({this.classDetails});

  @override
  _AssignmentState createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {
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

  Future<dynamic> checkAccessToken(id) async {
    final storage = new FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");
    //final accessToken = GlobalHelper.accessToken;

    var url = 'https://college-app-backend-production.up.railway.app/api/deleteAssignment';
    Map body = {"classId": widget.classDetails["_id"], "assignmentId": id};
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
  deleteAssignment(id) async {
    var responseJson = await checkAccessToken(id);
    if (responseJson['msg'] == "Access token expired") {
      await refresh();
      responseJson = await checkAccessToken(id);
    }
    if (responseJson['success'] == true) {
      ClassRoomHelper.shared.fetchClassInfo(widget.classDetails["_id"]);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    ClassRoomHelper.shared.fetchClassInfo(widget.classDetails["_id"]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Assignment"),
        // ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top:12.0),
            child: Stack(
              children: [
                StreamBuilder(
                  stream: ClassRoomStreamControllerHelper.shared.classInfoStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active && GlobalHelper.loading == false) {
                      if (snapshot.hasData) {
                        final List items = snapshot.data["assignments"];
                        return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext ctxt, int i) {
                            return _buildListItems(
                              items[i]["_id"],
                              items[i]["submissionDate"],
                              items[i]["title"],
                              Moment.parse(items[i]["createdAt"]).format('dd-MM-yyyy'),
                              items[i]["uri"]
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
                if( GlobalHelper.userRole == "teacher")Padding(
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
                                      NewAssignment(classDetails: widget.classDetails)));
                        },
                        label: Text('Add New Assignment'),
                        icon: Icon(Icons.add),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
  Widget _buildListItems(
  String id,
  String title,
  // String submissionTime;
  String submissionDate,
  String uploadDate,
  String uri) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 15,
                height: 10,
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(5),
                    )),
              ),
              SizedBox(
                width: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    uploadDate,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey[300]),
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.only(right: 10, left: 30),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.assignment,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await launch(uri);
                        },
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.download, size: 12),
                            SizedBox(width: 10),
                            Text(
                              "PDF",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Submission Date: ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            submissionDate,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      if(GlobalHelper.userRole== "teacher")
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.deepOrange,
                          ),
                          splashColor: Colors.white54,
                          onPressed: () {
                            setState(() {
                              GlobalHelper.loading  = true;
                            });
                            deleteAssignment(id);
                          },
                          iconSize: 25,
                        ),
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}
