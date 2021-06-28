import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:our_e_college_app/components/buysell/buySellDetails.dart';
import 'package:our_e_college_app/components/buysell/buysell-helper.dart';
import 'package:our_e_college_app/components/buysell/newPostSell.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../global-helper.dart';

class SellList extends StatefulWidget {
  @override
  _SellListState createState() => _SellListState();
}

class _SellListState extends State<SellList> {
  List items;
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
  Future<dynamic> checkAccessToken(String id) async {
        String url = "https://college-app-backend.herokuapp.com/api/college-olx/deleteItem";
        final storage = new FlutterSecureStorage();
        final accessToken = await storage.read(key: "accessToken");
        // final  accessToken = GlobalHelper.accessToken;

        final body = json.encode({
          "id": id});
        final response = await http.delete(Uri.parse(url),
            headers: {
              "Authorization": "Bearer $accessToken",
              "Content-Type": "application/json",
            },
            body: body);
        try{
          if(response.statusCode == 200){
            return json.decode(response.body);
          }
          else{
            print(json.decode(response.body)["msg"]);
          }
        }
        catch(err){
          print(err);
        }
  }
  Future<void> deleteItem(String id) async {
    var responseJson = await checkAccessToken(id);
    if (responseJson['msg'] == "Access token expired") {
      await refresh();
      responseJson = await checkAccessToken(id);
    }
    if (responseJson['success'] == true) {
      BuySellHelper.shared.fetchSellItemsList();
    }
    else{
      print(responseJson['msg']);
    }
    // print(responseJson);
  }
  @override
  void initState() {
    // TODO: implement initState
    BuySellHelper.shared.fetchSellItemsList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(75.0),
                topRight: Radius.circular(75.0),
              ),
            ),
            child: Padding(
                padding: EdgeInsets.only(top: 45.0),
                child: Container(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: StreamBuilder(
                    stream: BuySellStreamControllerHelper.shared.sellListStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active && GlobalHelper.loading == false) {
                        if (snapshot.hasData) {
                          items = snapshot.data;
                          return ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (BuildContext ctxt, int i) {
                                return _buildListItems(
                                  items[i]["_id"],
                                  items[i]["itemImageUri"],
                                  items[i]["itemName"],
                                  items[i]["itemPrice"],
                                  items[i]["sellerName"],
                                  items[i]["sellerRoom"],
                                  items[i]["sellerContact"],
                                );
                              });
                        }
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ))),
          ),
          Positioned(
            bottom: 20,
            right: 30,
            child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => NewPostSell()));
                },
                child: Icon(Icons.add)),
          ),
        ],
      ),
    );
  }

  Widget _buildListItems(
      String docId,
      String imgPath,
      String itemName,
      String itemPrice,
      String sellerName,
      String sellerRoom,
      String sellerContact) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey[300]),
            borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(20),
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BuySellDetails(
                          itemImageUri: imgPath,
                          itemName: itemName,
                          itemPrice: itemPrice,
                          sellerName: sellerName,
                          sellerRoom: sellerRoom,
                          sellerContact: sellerContact)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        child: Row(children: [
                      Hero(
                          tag: imgPath,
                          child: Image(
                              image: NetworkImage(imgPath),
                              fit: BoxFit.cover,
                              height: 30.0,
                              width: 30.0)),
                      SizedBox(width: 10.0),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(itemName,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 10.0),
                            Text('Rs. ' + itemPrice,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 15.0,
                                    color: Colors.grey))
                          ])
                    ])),
                    IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.grey,
                        onPressed: () {
                          setState(() {
                            GlobalHelper.loading = true;
                          });
                          deleteItem(docId);
                        })
                  ],
                ))));
  }
}
