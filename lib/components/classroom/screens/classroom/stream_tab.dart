import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:our_e_college_app/components/classroom/widgets/comment_composer.dart';
import 'package:our_e_college_app/components/classroom/classroom_helper.dart';
import 'package:http/http.dart' as http;
import 'package:our_e_college_app/global-helper.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StreamTab extends StatefulWidget {
  AssetImage bannerImg;
  String className;
  var classDetails;

  StreamTab({this.bannerImg, this.className,this.classDetails});

  @override
  _StreamTabState createState() => _StreamTabState();
}

class _StreamTabState extends State<StreamTab> {
  final message_for_class = TextEditingController();
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

    var url = 'https://college-app-backend-production.up.railway.app/api/uploadMessage';
    Map body =  {
      "classId": widget.classDetails["_id"],
      "message": message_for_class.text
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
  uploadMessage() async {
    var responseJson = await checkAccessToken();
    if (responseJson['msg'] == "Access token expired") {
      await refresh();
      responseJson = await checkAccessToken();
    }
    if (responseJson['success'] == true) {
      message_for_class.clear();
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
      appBar: AppBar(
        title: Text("Stream"),
      ),
      body: Column(
        children: [
          Container(
            height: 120,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Image(
                    image: widget.bannerImg,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: 200,
                  alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.only(bottom: 40, left: 30),
                  child: Text(
                    widget.className,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          if (GlobalHelper.userRole != "student")
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextFormField(
                  controller: message_for_class,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Send Message",
                    suffixIcon: InkWell(
                        child: Icon(
                          Icons.send,
                          color: Colors.deepOrange,
                        ),
                        onTap: () {
                          print("send message");
                          setState(() {
                            GlobalHelper.loading = true;
                          });
                          uploadMessage();
                        }),
                  )),
            ),
          Expanded(
            child: StreamBuilder(
              stream: ClassRoomStreamControllerHelper.shared.classInfoStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active && GlobalHelper.loading == false) {
                  if (snapshot.hasData) {
                    final List items = snapshot.data["messages"];
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext ctxt, int i) {
                        return CommentComposer(
                          classId: widget.classDetails["_id"],
                          id: items[i]["_id"],
                          date: Moment.parse(items[i]["createdAt"])
                              .format('dd-MM-yyyy'),
                          message: items[i]["message"],
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
          )
        ],
      ),
    );
  }
}
