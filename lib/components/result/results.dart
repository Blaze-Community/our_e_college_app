import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:our_e_college_app/components/classroom/classroom_helper.dart';
import 'package:our_e_college_app/components/result/newResult.dart';
import 'package:our_e_college_app/global-helper.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Result extends StatefulWidget {
  final classDetails;
  Result({this.classDetails});
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {

  @override
  void initState() {
    ClassRoomHelper.shared.fetchClassInfo(widget.classDetails["_id"]);
    super.initState();
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

    var url = 'https://college-app-backend.herokuapp.com/api/deleteResult';
    Map body = {"classId": widget.classDetails["_id"], "resultId":id};
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
  deleteResult(id) async {
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
  Widget build(BuildContext context) {
    return Scaffold(
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
                        final List items = snapshot.data["results"];
                        return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext ctxt, int i) {
                            return _buildListItems(
                              items[i]["_id"],
                              items[i]["title"],
                              Moment.parse(items[i]["createdAt"]).format('dd-MM-yyyy'),
                              items[i]["uri"],
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
                if(GlobalHelper.userRole == "teacher")Padding(
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
                                      NewResult(classDetails: widget.classDetails,)));
                        },
                        label: Text('Add Result'),
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
                mainAxisAlignment: MainAxisAlignment.start,
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
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey[300]),
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.only(right: 10, left: 30),
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Row(
                      children:[
                        OutlinedButton(
                          onPressed: () async {
                            await launch(uri);
                          },
                          child: Row(
                            children: [
                              Icon(FontAwesomeIcons.download, size: 12),
                              SizedBox(width: 10),
                              Text(
                                "MARKSHEET",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
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
                              deleteResult(id);
                            },
                            iconSize: 25,
                          ),
                      ])
                ],
              ))
        ],
      ),
    );
  }
}
