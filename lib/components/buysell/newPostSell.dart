import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:our_e_college_app/components/buysell/sellList.dart';
import 'package:uuid/uuid.dart';

import 'buySell.dart';

class NewPostSell extends StatefulWidget {
  @override
  _NewPostSellState createState() => _NewPostSellState();
}

class _NewPostSellState extends State<NewPostSell> {
  final picker = ImagePicker();
  final ItemName = TextEditingController();
  final ItemPrice = TextEditingController();
  final SellerName = TextEditingController();
  final SellerRoom = TextEditingController();
  final SellerContact = TextEditingController();
  String ItemImageUri;
  bool loading = false;
  Future getItemImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      ItemImageUri = pickedFile.path;
    });
    //print("upload file ${await uploadFile(pickedFile.path)}");
    //uploadFile(pickedFile.path);
  }
  UploadItem() async {
    User user = FirebaseAuth.instance.currentUser;
    var uid = user.uid;
      try {
        var uuid = Uuid().v1();
        await FirebaseStorage.instance
            .ref('College-Olx/${uuid}')
            .putFile(File(ItemImageUri))
            .then((snapshot) async {
            var uri = await snapshot.ref.getDownloadURL();
            print("image added");
          CollectionReference itemsCollection = FirebaseFirestore.instance
                .collection('College-Olx');
          await itemsCollection.doc(uuid).set({
            "uid":uid,
            "itemName":ItemName.text,
            "itemPrice":ItemPrice.text,
            "itemPrice":uri,
            "sellerName":SellerName.text,
            "sellerRoom":SellerRoom.text,
            "sellerContact":SellerContact.text})
              .then((value) {
                print("Item Added");
                setState(() {
                  ItemName.clear();
                  ItemPrice.clear();
                  SellerName.clear();
                  SellerRoom.clear();
                  SellerContact.clear();
                  ItemImageUri=null;
                  loading = false;
                });
                Navigator.pop(context);
              })
              .catchError((error) => print("Failed to add item: $error"));;
        });
      } on FirebaseException catch (e) {
        // e.g, e.code == 'canceled'
        print(e.code);
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
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {},
              color: Colors.white,
            )
          ],
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
            padding: const EdgeInsets.only(top:45.0),
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
                      Container(height: 1.0, color: Colors.deepOrange, width: 50.0),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.fromLTRB(10,2,10,2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.deepPurple)
                        ),
                        child: TextField(
                          controller: ItemName,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Item Name",
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.fromLTRB(10,2,10,2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.deepPurple)
                        ),
                        child: TextField(
                          controller: ItemPrice,
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
                        )
                      ),
                      SizedBox(height: 40),
                      Text('Contact Details',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16.0,
                            color: Colors.grey)),
                      SizedBox(height: 5),
                      Container(height: 1.0, color: Colors.deepOrange, width: 50.0),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.fromLTRB(10,2,10,2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.deepPurple)
                        ),
                        child: TextField(
                          controller: SellerName,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Name",
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.fromLTRB(10,2,10,2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.deepPurple)
                        ),
                        child: TextField(
                          controller: SellerRoom,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Room No.",
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.fromLTRB(10,2,10,2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.deepPurple)
                        ),
                        child: TextField(
                          controller: SellerContact,
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
                            loading =true;
                          });
                          UploadItem();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child:  (loading==true)?
                          CircularProgressIndicator(
                            color: Colors.white,
                          ):
                          Row(
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
                        )
                      ),
                      SizedBox(height: 30)
                    ],
                  )

                ),
              ),
            ),
          ),
        )
    );
  }
}