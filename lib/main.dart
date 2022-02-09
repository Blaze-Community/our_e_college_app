import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:our_e_college_app/LoginScreen.dart';
import 'package:our_e_college_app/app.dart';
import 'package:our_e_college_app/global-helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'College App',
      theme: ThemeData(
          primarySwatch: Colors.deepOrange,),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var isloggedIn = false;

  getValidationData() async {
    final storage = new FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");
    //   final accessToken = GlobalHelper.accessToken;
    print("access token $accessToken");
    if(accessToken != null){
        setState(() {
          isloggedIn = true;
        });
    }
  }
  @override
  Future<void> initState() {
    // TODO: implement initState
    getValidationData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (isloggedIn != false)? App():LoginScreen()
    );
  }
}
