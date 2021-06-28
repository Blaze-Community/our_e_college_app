import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class GlobalHelper {

  static final shared = GlobalHelper();
  static var loading = false;
  // static var accessToken = "";
  // static var refreshToken = "";
  static var userRole = "";

  Future refresh() async {
    String url = 'https://college-app-backend.herokuapp.com/api/refresh';
    final storage = new FlutterSecureStorage();
    final refreshToken = await storage.read(key: "refreshToken");
    // final refreshToken = GlobalHelper.refreshToken;
    print("refreshtoken $refreshToken");
    final body = json.encode({"token": refreshToken});
    final response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: body);
    print("responsejson ${response.statusCode}");
    if(response.statusCode == 200){
      final responseJson = json.decode(response.body);
      if (responseJson['msg'] == "Refresh token expired, Please Login again!") {
        // refresh token expired, show dailogue that says user to login again.
        print("Refresh token expired, please login again");
      }
      final accessToken = responseJson['accessToken'];
      await storage.write(key: "accessToken", value: accessToken);
      print("new token on refresh ${accessToken}");
      // GlobalHelper.accessToken = accessToken;
    }
    else{
      print(json.decode(response.body)["msg"]);
    }
  }
  Future<dynamic> checkAccessToken() async {
    String url = 'https://college-app-backend.herokuapp.com/api/userInfo';
    final storage = new FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");
      //final accessToken = GlobalHelper.accessToken;
    print("new Token ${accessToken}");
    final response = await http.get(Uri.parse(url), headers: {
      "Authorization": "Bearer $accessToken",
    });
    try{
      if(response.statusCode == 200){
        return json.decode(response.body);
      }
      else{
        print(json.decode(response.body)["msg"]);
      }
    }
    catch(err){
      print("Error: $err");
    }
  }
  fetchCurrentUser() async {
    var responseJson = await checkAccessToken();
    if (responseJson['msg'] == "Access token expired") {
      await refresh();
      responseJson = await checkAccessToken();
    }
    print("fetchuser ${responseJson}");
    userRole = responseJson["role"];
    return responseJson;
  }
  }