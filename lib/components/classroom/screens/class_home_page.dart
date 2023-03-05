import 'dart:convert';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:our_e_college_app/components/classroom/classroom_helper.dart';
import 'package:our_e_college_app/components/classroom/create_join/create_class.dart';
import 'package:our_e_college_app/components/classroom/create_join/join_class.dart';
import 'package:our_e_college_app/components/classroom/data/classrooms.dart';
import 'package:our_e_college_app/global-helper.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'class_room_page.dart';

class ClassRoomHomePage extends StatefulWidget {
  @override
  _ClassRoomHomePageState createState() => _ClassRoomHomePageState();
}

class _ClassRoomHomePageState extends State<ClassRoomHomePage> {
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
      //GlobalHelper.accessToken = accessToken;
    }
    else{
      print(json.decode(response.body)["msg"]);
    }
  }

  Future<dynamic> checkAccessToken(classId) async {
    String url = "https://college-app-backend-production.up.railway.app/api/deleteClass";

    final storage = new FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");
    // final accessToken = GlobalHelper.accessToken;

    final body = json.encode({
      "classId": classId});
    final response = await http.delete(Uri.parse(url),
        headers: {
          "Authorization": "Bearer $accessToken",
          "Content-Type": "application/json",
        },
        body: body);
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
  Future<void> deleteClass(classId) async {
    var responseJson = await checkAccessToken(classId);
    if (responseJson['msg'] == "Access token expired") {
      await refresh();
      responseJson = await checkAccessToken(classId);
    }

    if (responseJson['success'] == true) {
      ClassRoomHelper.shared.fetchClassRoomlist();
    }
    else{
      print(responseJson['msg']);
    }
    // print(responseJson);
  }

  @override
  void initState() {
    // TODO: implement initState
    ClassRoomHelper.shared.fetchClassRoomlist();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            StreamBuilder(
              stream: ClassRoomStreamControllerHelper.shared.classListStream,
              builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.active && GlobalHelper.loading == false){
                  if(snapshot.hasData){
                    List classRoomList = snapshot.data["classes"];
                    return  ListView.builder(
                        itemCount: classRoomList.length,
                        itemBuilder: (context, int index) {
                            return GestureDetector(
                              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => ClassRoomPage1(
                                    classDetails:classRoomList[index],
                                    className: classRoomList[index]["subject"],
                                    bannerImg: classRoomDesingList[index]["bannerImg"],
                                  ))),
                              child: Container(
                                  height: 140,
                                  margin: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.orange,
                                      image: DecorationImage(
                                        image: classRoomDesingList[index]["bannerImg"],
                                        fit: BoxFit.cover,
                                      )
                                  ),
                                  child:Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  classRoomList[index]["subject"],
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    letterSpacing: 1,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons.copy,
                                                        color: Colors.white,
                                                      ),
                                                      splashColor: Colors.white54,
                                                      onPressed: () {
                                                        FlutterClipboard.copy(classRoomList[index]["enrolKey"])
                                                            .then(( value ) => print('copied'));

                                                      },
                                                      iconSize: 25,
                                                    ),
                                                    if(GlobalHelper.userRole== "teacher")
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color: Colors.white,
                                                        ),
                                                        splashColor: Colors.white54,
                                                        onPressed: () {
                                                          setState(() {
                                                            GlobalHelper.loading  = true;
                                                          });
                                                          deleteClass(classRoomList[index]["_id"]);
                                                        },
                                                        iconSize: 25,
                                                      ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  classRoomList[index]["branch"],
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                                SizedBox(
                                                  width: 6,
                                                ),
                                                Text(
                                                  classRoomList[index]["section"],
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              classRoomList[index]["batch"],
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  letterSpacing: 1),
                                            ),
                                          ],
                                        ),

                                        Text("Created By: " +
                                            classRoomList[index]["createdBy"]["profileName"],
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white54,
                                              letterSpacing: 1),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                            );
                        });
                  }
                }
                return Center(child: CircularProgressIndicator());
              }
              ,
            ),
            Padding(
              // bottom: 10,
                padding: EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context){
                                if (GlobalHelper.userRole == "student") {
                                  return joinclass();
                                } else {
                                  return createclass();
                                }
                              }));
                    },
                    label: (GlobalHelper.userRole == "student")?Text('Join Class'):Text('Create Class'),
                    icon: Icon(Icons.add),
                  ),
                )),
        ]),
    );
  }
}
