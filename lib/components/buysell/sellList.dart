import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:our_e_college_app/components/buysell/buySellDetails.dart';
import 'package:our_e_college_app/components/buysell/newPostSell.dart';

class SellList extends StatefulWidget {
  @override
  _SellListState createState() => _SellListState();
}

class _SellListState extends State<SellList> {
  List items;
  Future<void> deleteItem(String uuid) async {
    CollectionReference itemsCollection = FirebaseFirestore.instance
        .collection('College-Olx');
    await itemsCollection
        .doc(uuid)
        .delete()
        .then((value) {
          print("Item Deleted");
        })
        .catchError((error) => print("Failed to delete user: $error"));
  }
  fetchSellItemsList() {
    User user = FirebaseAuth.instance.currentUser;
    var uid = user.uid;
    CollectionReference itemsCollection = FirebaseFirestore.instance
        .collection('College-Olx');
    return itemsCollection
        .where('uid', isEqualTo: uid)
        .snapshots();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:30.0),
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
                      padding: const EdgeInsets.symmetric(horizontal:20.0),
                      child: StreamBuilder(
                        stream: fetchSellItemsList(),
                        builder: (context,snapshot){
                          if(snapshot.connectionState == ConnectionState.active){
                            if(snapshot.hasData){
                             items = snapshot.data.docs;
                              return ListView.builder(
                                  itemCount: items.length,
                                  itemBuilder:  (BuildContext ctxt, int i) {
                                    return _buildListItems(
                                      items[i].id,
                                      items[i]["itemUri"],
                                      items[i]["itemName"],
                                      items[i]["itemPrice"],
                                      items[i]["sellerName"],
                                      items[i]["sellerRoom"],
                                      items[i]["sellerContact"],
                                    );
                                  }
                              );
                            }
                          }
                          return Center(child: CircularProgressIndicator());
                        }
                        ,
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

  Widget _buildListItems(String docId,String imgPath, String itemName, String itemPrice, String sellerName,String sellerRoom,String sellerContact) {
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
                        sellerContact: sellerContact
                      )));
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
                          width: 30.0
                        )
                      ),
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
