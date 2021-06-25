import 'dart:async';
import 'dart:convert';

import 'package:our_e_college_app/global.dart' as Global;
import 'package:http/http.dart' as http;

class ClassRoomHelper {

  static final shared = ClassRoomHelper();
  static var loading = false;
  Future fetchClassRoomlist(collegeUserId) async {
    if(Global.user == "Teacher"){
      var url = Uri.parse('http://localhost:5000/api/teacherClasses/${collegeUserId}');
      var response = await http.get(url);
      print(json.decode(response.body));
      ClassRoomStreamControllerHelper.shared._classListStreamController.add(json.decode(response.body));
    }
    else{
      var url = Uri.parse('http://localhost:5000/api/studentClasses/${collegeUserId}');
      var response = await http.get(url);
      ClassRoomStreamControllerHelper.shared._classListStreamController.add(json.decode(response.body));
    }
    loading = false;
  }

  Future fetchClassInfo(classId) async {
      var url = Uri.parse('http://localhost:5000/api/classInfo/${classId}');
      var response = await http.get(url);
      ClassRoomStreamControllerHelper.shared._classInfoStreamController.add(json.decode(response.body));
      loading = false;
  }
}

class ClassRoomStreamControllerHelper{

  static var shared = ClassRoomStreamControllerHelper();

  StreamController _classListStreamController = StreamController.broadcast();
  StreamController _classInfoStreamController = StreamController.broadcast();

  Stream get classListStream => _classListStreamController.stream;
  Stream get classInfostream => _classInfoStreamController.stream;


}