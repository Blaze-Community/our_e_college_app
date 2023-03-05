import 'package:flutter/material.dart';
import 'package:our_e_college_app/LoginScreen.dart';
import 'package:our_e_college_app/profilesection/ProfileListItems/changepassword.dart';
import 'package:our_e_college_app/profilesection/ProfileListItems/editprofile.dart';
import 'package:our_e_college_app/profilesection/profilelistitem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../global-helper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String profileImageUri;
  String profileName;

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

  Future<dynamic> checkAccessToken() async {
    String url = 'https://college-app-backend-production.up.railway.app/api/userInfo';
    final storage = new FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");
    //final accessToken = GlobalHelper.accessToken;
    final response = await http.get(Uri.parse(url), headers: {
      "Authorization": "Bearer $accessToken",
    });
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

  Future getProfileImageFromDatabase() async {
    var responseJson = await checkAccessToken();
    if (responseJson['msg'] == "Access token expired") {
      await refresh();
      responseJson = await checkAccessToken();
    }
    print(responseJson);
    return responseJson;
  }

  var calendarLink;

  void acadmicCalendar() async {
    String url = 'https://iiitn-web-crawler-production.up.railway.app/acadmic-calendar';
    final response = await http.get(Uri.parse(url)).then((value){
      print("resonsejson ${value}");
    });

    final responseJson = json.decode(response.body);
    setState(() {
      calendarLink = responseJson[1];
      // print(lis);
    });
  }

  void initState() {
    acadmicCalendar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              FutureBuilder(
                future: getProfileImageFromDatabase(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      profileImageUri = snapshot.data["profilePhotoUri"];
                      profileName = snapshot.data["profileName"];
                      return Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.only(top: 30),
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.white,
                                  foregroundImage:
                                      (snapshot.data["profilePhotoUri"].length >
                                              0)
                                          ? NetworkImage(
                                              snapshot.data["profilePhotoUri"])
                                          : AssetImage("assets/splash.jpg"),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            snapshot.data["profileName"],
                          ),
                          SizedBox(height: 5),
                          Text(
                            snapshot.data["email"],
                          ),
                        ],
                      );
                    }
                  }
                  return Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        margin: EdgeInsets.only(top: 30),
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Center(child: CircularProgressIndicator()),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'StudentName',
                      ),
                      SizedBox(height: 5),
                      Text(
                        'E-Mail',
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 20),
              Expanded(
                  child: Column(children: [
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: ListView(
                  children: [
                    ProfileListItems(
                      icon: Icons.edit,
                      text: 'Edit Profile',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => EditProfile(
                                      profileImageUri: profileImageUri,
                                      profileName: profileName,
                                    )));
                      },
                    ),
                    ProfileListItems(
                      icon: Icons.password,
                      text: 'Change Password',
                      onPressed: () {
                        print("password change");
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             ChangePassword()));
                      },
                    ),
                    ProfileListItems(
                        icon: Icons.calendar_today,
                        text: 'Acadmic Calendar',
                        onPressed: () async {
                          print(calendarLink);
                          await launch(calendarLink);
                        }),
                    ProfileListItems(
                      icon: Icons.notifications,
                      text: 'Notification',
                      onPressed: () {},
                    ),
                    ProfileListItems(
                      icon: Icons.security,
                      text: 'About Us',
                      onPressed: () {},
                    ),
                    ProfileListItems(
                        icon: Icons.logout,
                        text: 'Logout',
                        onPressed: () async {
                          // await FirebaseAuth.instance.signOut();
                          final storage = new FlutterSecureStorage();
                          await storage.delete(key: "accessToken");
                          await storage.delete(key: "refreshToken");
                          // GlobalHelper.accessToken = "";
                          // GlobalHelper.refreshToken = "";

                          Navigator.pushReplacement(
                              ContextKeeper.buildContext,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginScreen()));
                        }),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ))
              ])),
            ],
          ),
        ));
  }
}
