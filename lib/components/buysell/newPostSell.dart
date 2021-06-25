import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  Future getItemImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      itemImageUri = pickedFile.path;
    });
    //print("upload file ${await uploadFile(pickedFile.path)}");
    //uploadFile(pickedFile.path);
  }


  Future<void> uploadItem() async {
    String url = "http://localhost:5000/api/additem";
    final response = await http.post((Uri.parse(url)), body: {
      "itemName": itemName.text,
      "itemPrice": itemPrice.text,
      "itemImageUri": "https://images5.alphacoders.com/106/1062290.jpg",
      "sellerName": sellerName.text,
      "sellerRoom": sellerRoom.text,
      "sellerContact": sellerContact.text,
      "email": "bt19cse005@gmail.com"
    });
    final responseJson = json.decode(response.body);
    print(responseJson);
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
                          });
                          uploadItem();
                          Navigator.of(context).pop();
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
