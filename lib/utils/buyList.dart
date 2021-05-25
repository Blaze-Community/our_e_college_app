import 'package:flutter/material.dart';
import 'package:our_e_college_app/components/buySellDetails.dart';

class BuyList extends StatefulWidget {
  @override
  _BuyListState createState() => _BuyListState();
}

class _BuyListState extends State<BuyList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  ListView(
            children: <Widget>[
              SizedBox(height: 80.0),
              Container(
                height: MediaQuery.of(context).size.height - 185.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(75.0),
                      topRight: Radius.circular(75.0),
                      ),
                ),
                child: ListView(
                  padding: EdgeInsets.only(left: 25.0, right: 20.0),
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 45.0),
                        child: Container(
                            height: MediaQuery.of(context).size.height - 300.0,
                            child: ListView(children: [
                              _buildListItems('plate1.png', 'M & G Book', '50.00'),
                              _buildListItems(
                                  'plate1.png', 'Maths II Book', '50.00'),
                              _buildListItems('plate1.png', 'Calculator', '50.00'),
                              _buildListItems('plate1.png', 'Calculator', '50.00'),
                              _buildListItems('plate1.png', 'Calculator', '50.00'),
                              _buildListItems('plate1.png', 'Calculator', '50.00'),
                              _buildListItems(
                                  'plate1.png', 'Phillips Kettle', '50.00')
                            ]))),
                  ],
                ),
              )
            ],
          ),
    );
  }

  Widget _buildListItems(String imgPath, String itemName, String itemPrice) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey[300]),
            borderRadius: BorderRadius.circular(20),
            ),
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(20),
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BuySellDetails(
                          heroTag: imgPath,
                          itemName: itemName,
                          itemPrice: itemPrice)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        child: Row(children: [
                      // Hero(
                      //   tag: imgPath,
                      //   child: Image(
                      //     image: AssetImage(imgPath),
                      //     fit: BoxFit.cover,
                      //     height: 30.0,
                      //     width: 30.0
                      //   )
                      // ),
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
                        icon: Icon(Icons.favorite_border),
                        color: Colors.grey,
                        onPressed: () {
                          
                        })
                  ],
                ))));
  }
}