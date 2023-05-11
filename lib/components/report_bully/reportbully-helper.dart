import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import '../../global-helper.dart';
import 'package:flutter/material.dart';
class ReportBullyHelper {

  static final shared = ReportBullyHelper();

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

  Future fetchBullyItemsList() async {
    String url = "https://college-app-backend-production.up.railway.app/api/bully";
    final storage = new FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");
    //final accessToken = GlobalHelper.accessToken;
    final response = await http.get(Uri.parse(url), headers: {
      "Authorization": "Bearer $accessToken",
    });
    var responseJson = json.decode(response.body);

    print("responseJson ${responseJson}");

    if (responseJson['msg'] == "Access token expired") {
      await refresh();
      responseJson = await fetchBullyItemsList();
    }
    if(responseJson['success'] == true){
      ReportBullyStreamControllerHelper.shared._bullyListStreamController.add(responseJson["list"]);
    }
    else{
      print(responseJson["msg"]);
    }
    GlobalHelper.loading = false;
  }
}

class ReportBullyStreamControllerHelper{

  static var shared = ReportBullyStreamControllerHelper();

  StreamController _bullyListStreamController = StreamController.broadcast();

  Stream get bullyListStream => _bullyListStreamController.stream;


}