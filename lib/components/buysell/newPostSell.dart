import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:our_e_college_app/components/buysell/buysell-helper.dart';
import 'package:uuid/uuid.dart';

import '../../global-helper.dart';

class NewPostSell extends StatefulWidget {
  @override
  _NewPostSellState createState() => _NewPostSellState();
}

class _NewPostSellState extends State<NewPostSell> {
  final picker = ImagePicker();
  final itemName = TextEditingController();
  final itemPrice = TextEditingController();
  final sellerName = TextEditingController();
  final sellerRoom = TextEditingController();
  final sellerContact = TextEditingController();
  String itemImageUri;
  bool loading = false;

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
    try {
      var uuid = Uuid().v1();
      return await FirebaseStorage.instance
          .ref('Temporary-Storage/${uuid}')
          .putFile(File(itemImageUri))
          .then((snapshot) async {
          var uri = await snapshot.ref.getDownloadURL();
          String url = 'https://college-app-backend-production.up.railway.app/api/college-olx/additem';
          final storage = new FlutterSecureStorage();
          final accessToken = await storage.read(key: "accessToken");
          //final accessToken = GlobalHelper.accessToken;

          final body = json.encode({
            "itemName": itemName.text,
            "itemPrice": itemPrice.text,
            "itemImageUri": uri,
            "sellerName": sellerName.text,
            "sellerRoom": sellerRoom.text,
            "sellerContact": sellerContact.text
          });

          final response = await http.post(Uri.parse(url),
              headers: {
                "Authorization": "Bearer $accessToken",
                "Content-Type": "application/json",
              },
              body: body);
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
      });
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print(e.code);
    }
  }

  Future getItemImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      itemImageUri = pickedFile.path;
    });
  }

  Future<void> uploadItem() async {
    var responseJson = await checkAccessToken();
    if (responseJson['msg'] == "Access token expired") {
      await refresh();
      responseJson = await checkAccessToken();
    }
    if (responseJson['success'] == true) {
      Navigator.pop(context);
      BuySellHelper.shared.fetchSellItemsList();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text('Add New Post',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18.0,
                  color: Colors.white)),
          centerTitle: true,
        ),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(75.0),
              topRight: Radius.circular(75.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 45.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Text('Item Details',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16.0,
                            color: Colors.grey)),
                    SizedBox(height: 5),
                    Container(
                        height: 1.0, color: Colors.deepOrange, width: 50.0),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.deepPurple)),
                      child: TextField(
                        controller: itemName,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Item Name",
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.deepPurple)),
                      child: TextField(
                        controller: itemPrice,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Price",
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    OutlinedButton(
                        onPressed: () {
                          getItemImage();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.upload, size: 25),
                              SizedBox(width: 10),
                              Text(
                                "Upload Image",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(height: 40),
                    Text('Contact Details',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16.0,
                            color: Colors.grey)),
                    SizedBox(height: 5),
                    Container(
                        height: 1.0, color: Colors.deepOrange, width: 50.0),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.deepPurple)),
                      child: TextField(
                        controller: sellerName,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Name",
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.deepPurple)),
                      child: TextField(
                        controller: sellerRoom,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Room No.",
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.deepPurple)),
                      child: TextField(
                        controller: sellerContact,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Contact No.",
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            loading = true;
                            GlobalHelper.loading = true;
                          });
                          uploadItem();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: (loading == true)
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.publish, size: 25),
                                    SizedBox(width: 10),
                                    Text(
                                      "Submit",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                        )),
                    SizedBox(height: 30)
                  ],
                )),
              ),
            ),
          ),
        ));
  }
}
