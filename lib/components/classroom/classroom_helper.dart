import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:our_e_college_app/global-helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class ClassRoomHelper {

  static final shared = ClassRoomHelper();

  Future refresh() async {
    String url = 'https://college-app-backend-production.up.railway.app/api/refresh';
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

  Future fetchClassRoomlist() async {
      var url = 'https://college-app-backend-production.up.railway.app/api/classes';
      final storage = new FlutterSecureStorage();
      final accessToken = await storage.read(key: "accessToken");
       //final accessToken = GlobalHelper.accessToken;
      final response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer $accessToken",
      });
      var responseJson = json.decode(response.body);

      if (responseJson['msg'] == "Access token expired") {
        await refresh();
        responseJson = await fetchClassRoomlist();
      }
      if(responseJson['success'] == true){
        ClassRoomStreamControllerHelper.shared._classListStreamController.add(responseJson);
      }
      else{
        print(responseJson["msg"]);
      }
      GlobalHelper.loading = false;
  }

  Future fetchClassInfo(classId) async {
      var url = 'https://college-app-backend-production.up.railway.app/api/classInfo/${classId}';
      final storage = new FlutterSecureStorage();
      final accessToken = await storage.read(key: "accessToken");
      //  final accessToken = GlobalHelper.accessToken;
      final response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer $accessToken",
      });
      var responseJson = json.decode(response.body);

      if (responseJson['msg'] == "Access token expired") {
        await refresh();
        responseJson = await fetchClassInfo(classId);
      }
      if(responseJson['success'] == true){
        ClassRoomStreamControllerHelper.shared._classInfoStreamController.add(responseJson["classInfo"]);
      }
      else{
        print(responseJson["msg"]);
      }
      GlobalHelper.loading = false;
  }

  Future fetchClassAttendence(classId,date) async {
    var url = 'https://college-app-backend-production.up.railway.app/api/getAttendence/${classId}/${date}';
    final storage = new FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");
    //  final accessToken = GlobalHelper.accessToken;
    final response = await http.get(Uri.parse(url), headers: {
      "Authorization": "Bearer $accessToken",
    });
    var responseJson = json.decode(response.body);

    if (responseJson['msg'] == "Access token expired") {
      await refresh();
      responseJson = await fetchClassAttendence(classId,date);
    }
    if(responseJson['success'] == true){
      ClassRoomStreamControllerHelper.shared._classAttendenceStreamController.add(responseJson["attendence"]);
    }
    else{
      print(responseJson["msg"]);
    }
    GlobalHelper.loading = false;
  }

  Future fetchClassStudentAttendence(classId) async {
    var url = 'https://college-app-backend-production.up.railway.app/api/getStudentAttendence/${classId}';
    final storage = new FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");
    //  final accessToken = GlobalHelper.accessToken;
    final response = await http.get(Uri.parse(url), headers: {
      "Authorization": "Bearer $accessToken",
    });
    var responseJson = json.decode(response.body);

    if (responseJson['msg'] == "Access token expired") {
      await refresh();
      responseJson = await fetchClassStudentAttendence(classId);
    }
    if(responseJson['success'] == true){
      ClassRoomStreamControllerHelper.shared._classStudentAttendenceStreamController.add(responseJson["attendence"]);
    }
    else{
      print(responseJson["msg"]);
    }
    GlobalHelper.loading = false;
  }

}

class ClassRoomStreamControllerHelper{

  static var shared = ClassRoomStreamControllerHelper();

  StreamController _classListStreamController = StreamController.broadcast();
  StreamController _classInfoStreamController = StreamController.broadcast();
  StreamController _classAttendenceStreamController = StreamController.broadcast();
  StreamController _classStudentAttendenceStreamController = StreamController.broadcast();

  Stream get classListStream => _classListStreamController.stream;
  Stream get classInfoStream => _classInfoStreamController.stream;
  Stream get classAttendenceStream => _classAttendenceStreamController.stream;
  Stream get classStudentAttendenceStream => _classStudentAttendenceStreamController.stream;


}