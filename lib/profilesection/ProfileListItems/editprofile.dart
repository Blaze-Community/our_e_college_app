import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:our_e_college_app/bottombar/bottomBarScreens.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EditProfile extends StatefulWidget {
  String profileImageUri;
  String profileName;
  EditProfile({this.profileImageUri, this.profileName});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final picker = ImagePicker();
  bool loading = false;
  String editProfileUri;
  var updateProfileUri;
  final myController = TextEditingController();

  Future refresh() async {
    String url = 'https://college-app-backend.herokuapp.com/api/refresh';
    final storage = new FlutterSecureStorage();
    final refreshToken = await storage.read(key: "refreshToken");
    final body = json.encode({"token": refreshToken});
    final response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: body);
    final responseJson = json.decode(response.body);
    if (responseJson['msg'] == "Refresh token expired, Please Login again!") {
      // refresh token expired, show dailogue that says user to login again.
      print("Refresh token expired, please login again");
    }
    final accessToken = responseJson['accessToken'];
    await storage.write(key: "accessToken", value: accessToken);
  }

  Future<dynamic> checkAccessToken() async {
    String url = 'https://college-app-backend.herokuapp.com/api/editprofile';
    final storage = new FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");

    final body = json.encode({
      "profilePhotoUri":
          (editProfileUri != null) ? editProfileUri : widget.profileImageUri,
      "profileName": myController.text
    });

    final response = await http.post(Uri.parse(url),
        headers: {
          "Authorization": "Bearer $accessToken",
          "Content-Type": "application/json",
        },
        body: body);

    final responseJson = json.decode(response.body);
    return responseJson;
  }

  Future saveFile() async {
    var responseJson = await checkAccessToken();
    if (responseJson['msg'] == "Access token expired") {
      await refresh();
      responseJson = await checkAccessToken();
    }

    print(responseJson);
    if (responseJson['success'] == true) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => ProfileScreen()),
          (Route<dynamic> route) => false);
    }
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      editProfileUri = pickedFile.path;
    });
    //print("upload file ${await uploadFile(pickedFile.path)}");
    //uploadFile(pickedFile.path);
  }

  bool showPassword = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getProfileImageFromDatabase();
    myController..text = widget.profileName;
    print("profileImage ${widget.profileImageUri}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.orange,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        getImage();
                      },
                      child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                          ),
                          child: (editProfileUri != null)
                              ? CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      FileImage(File(editProfileUri)),
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      (widget.profileImageUri.length > 0)
                                          ? NetworkImage(widget.profileImageUri)
                                          : AssetImage("assets/splash.jpg"),
                                )),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              TextFormField(
                controller: myController,
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        loading = true;
                      });
                      saveFile();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(horizontal: 50, vertical: 5)),
                      elevation: MaterialStateProperty.all<double>(2),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    child: (loading == true)
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Save",
                            style: TextStyle(fontSize: 14),
                          ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
