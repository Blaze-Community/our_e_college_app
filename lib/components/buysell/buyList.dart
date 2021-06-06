import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:our_e_college_app/components/buysell/buySellDetails.dart';

class BuyList extends StatefulWidget {
  @override
  _BuyListState createState() => _BuyListState();
}

class _BuyListState extends State<BuyList> {

   fetchBuyItemsList() {
    return FirebaseFirestore.instance
        .collection('College-Olx').snapshots();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:30.0),
      child: Container(
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
                    stream: fetchBuyItemsList(),
                    builder: (context,snapshot){
                      if(snapshot.connectionState == ConnectionState.active){
                          if(snapshot.hasData){
                            final List items = snapshot.data.docs;
                            return ListView.builder(
                                itemCount: items.length,
                                itemBuilder:  (BuildContext ctxt, int i) {
                                  return _buildListItems(
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
    );
  }

  Widget _buildListItems(String imgPath, String itemName, String itemPrice, String sellerName,String sellerRoom,String sellerContact) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              offset: const Offset(4, 4),
              blurRadius: 16,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BuySellDetails(
                      itemImageUri: imgPath,
                      itemName: itemName,
                      itemPrice: itemPrice,
                      sellerName: sellerName,
                      sellerRoom: sellerRoom,
                      sellerContact: sellerContact,
                     )));
            },
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 2.5,
                      child: Image.network(
                        imgPath,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: 60,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(itemName,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold)),
                            Text('Rs. ' + itemPrice,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 15.0,
                                    color: Colors.grey)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
