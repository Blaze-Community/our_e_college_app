import 'package:flutter/material.dart';

class NewPostSell extends StatefulWidget {
  @override
  _NewPostSellState createState() => _NewPostSellState();
}

class _NewPostSellState extends State<NewPostSell> {

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
        body: ListView(children: [
                Stack(children: [
                    Container(
                        height: MediaQuery.of(context).size.height - 82.0,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.transparent),
                    Positioned(
                        top: 75.0,
                        child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50.0),
                                      topRight: Radius.circular(50.0),
                                    ),
                                    color: Colors.white),
                                height: MediaQuery.of(context).size.height - 100.0,
                                width: MediaQuery.of(context).size.width
                              )
                    ),
                    SizedBox(height: 40),
                    Positioned(
                      top: 100,
                      left: 25.0,
                      right: 25.0,
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
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Price",
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          OutlinedButton(
                            onPressed: () {},
                            
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
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Contact No.",
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {},
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Row(
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
                        ],
                      )
                    )
                  ]
                )
              ]
            )
        );
  }
}
