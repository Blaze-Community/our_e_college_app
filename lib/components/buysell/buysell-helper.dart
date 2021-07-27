import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import '../../global-helper.dart';
import 'package:flutter/material.dart';
class BuySellHelper {

  static final shared = BuySellHelper();

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
      //GlobalHelper.accessToken = accessToken;
    }
    else{
      print(json.decode(response.body)["msg"]);
    }
  }

  Future fetchBuyItemsList() async {
    String url = "https://college-app-backend.herokuapp.com/api/college-olx/allItems";
    final storage = new FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");
    //final accessToken = GlobalHelper.accessToken;
    final response = await http.get(Uri.parse(url), headers: {
      "Authorization": "Bearer $accessToken",
    });
    var responseJson = json.decode(response.body);

    if (responseJson['msg'] == "Access token expired") {
      await refresh();
      responseJson = await fetchBuyItemsList();
    }
    if(responseJson['success'] == true){
      BuySellStreamControllerHelper.shared._buyListStreamController.add(responseJson["list"]);
    }
    else{
      print(responseJson["msg"]);
    }
    GlobalHelper.loading = false;
  }

  Future fetchSellItemsList() async {
    String url = "https://college-app-backend.herokuapp.com/api/college-olx/myItem";
    final storage = new FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");
    // final accessToken = GlobalHelper.accessToken;
    final response = await http.get(Uri.parse(url), headers: {
      "Authorization": "Bearer $accessToken",
    });
    var responseJson = json.decode(response.body);

    if (responseJson['msg'] == "Access token expired") {
      await refresh();
      responseJson = await fetchSellItemsList();
    }
    if(responseJson['success'] == true){
      BuySellStreamControllerHelper.shared._sellListStreamController.add(responseJson["list"]);
    }
    else{
      print(responseJson["msg"]);
    }
    GlobalHelper.loading = false;
  }

}

class BuySellStreamControllerHelper{

  static var shared = BuySellStreamControllerHelper();

  StreamController _buyListStreamController = StreamController.broadcast();
  StreamController _sellListStreamController = StreamController.broadcast();

  Stream get buyListStream => _buyListStreamController.stream;
  Stream get sellListStream => _sellListStreamController.stream;


}