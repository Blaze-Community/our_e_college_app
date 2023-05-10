import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:our_e_college_app/LoginScreen.dart';
import 'package:our_e_college_app/app.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'components/report_bully/uploader.dart';

void backGroundHandler() {
  WidgetsFlutterBinding.ensureInitialized();
  final notifications = FlutterLocalNotificationsPlugin();
  if (Platform.isAndroid) {
    BackgroundUploader.uploader.progress.listen((progress) {
      notifications.show(
        progress.taskId.hashCode,
        'DemoApp',
        'Upload in Progress',
        NotificationDetails(
          android: AndroidNotificationDetails(
            'DemoTestChannel',
            'High Importance Notifications',
            progress: progress.progress ?? 0,
            icon: '@mipmap/ic_launcher',
            enableVibration: false,
            importance: Importance.high,
            showProgress: true,
            onlyAlertOnce: true,
            maxProgress: 100,
            channelShowBadge: false,
          ),
          iOS: const IOSNotificationDetails(),
        ),
      );
    });
  }
  BackgroundUploader.uploader.result.listen((result) {
    notifications.cancel(result.taskId.hashCode);

    final successful = result.status == UploadTaskStatus.complete;

    String title = 'Upload Complete';
    if (result.status == UploadTaskStatus.failed) {
      title = 'Upload Failed';
    } else if (result.status == UploadTaskStatus.canceled) {
      title = 'Upload Canceled';
    }

    notifications
        .show(
      result.taskId.hashCode,
      'DemoApp',
      title,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'DemoTestChannel',
          'High Importance Notifications',
          icon: '@mipmap/ic_launcher',
          enableVibration: !successful,
          importance: result.status == UploadTaskStatus.failed
              ? Importance.high
              : Importance.min,
        ),
        iOS: const IOSNotificationDetails(
          presentAlert: true,
        ),
      ),
    )
        .catchError((e, stack) {});
  });
}


void notificationListerner() {
  BackgroundUploader.uploader.setBackgroundHandler(backGroundHandler);

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final initializationSettingsIOS = IOSInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    onDidReceiveLocalNotification:
        (int id, String title, String body, String payload) async {},
  );
  final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (payload) async {},
  );
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  notificationListerner();
  await Firebase.initializeApp();
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
