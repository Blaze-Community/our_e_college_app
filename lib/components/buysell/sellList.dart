import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:our_e_college_app/components/buysell/buySellDetails.dart';
import 'package:our_e_college_app/components/buysell/newPostSell.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SellList extends StatefulWidget {
  @override
  _SellListState createState() => _SellListState();
}

class _SellListState extends State<SellList> {
  List items;

  Future<void> deleteItem(String id) async {
    String url = "http://localhost:5000/api/deleteitem";
    final response = await http.post((Uri.parse(url)), body: {"id": id});
    final responseJson = json.decode(response.body);
    // print(responseJson);
  }

  Future fetchSellItemsList() async {
    String url = "http://localhost:5000/api/myitem";
    final response = await http
        .get((Uri.parse(url)), headers: {"email": "bt19cse005@gmail.com"});
    final responseJson = json.decode(response.body);
    // print(responseJson);
    return responseJson;
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
                    stream: fetchSellItemsList().asStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
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
                          deleteItem(docId);
                        })
                  ],
                ))));
  }
}
