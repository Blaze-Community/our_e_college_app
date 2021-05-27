import 'package:flutter/material.dart';
import 'package:our_e_college_app/components/buysell/buySellDetails.dart';
import 'package:our_e_college_app/components/buysell/newPostSell.dart';

class SellList extends StatefulWidget {
  @override
  _SellListState createState() => _SellListState();
}

class _SellListState extends State<SellList> {
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
                      child: ListView(children: [
                        _buildListItems(
                            'assets/plate1.png', 'M & G Book', '50.00'),
                        _buildListItems(
                            'assets/plate1.png', 'Maths II Book', '50.00'),
                        _buildListItems(
                            'assets/plate1.png', 'Calculator', '50.00'),
                        _buildListItems(
                            'assets/plate1.png', 'Calculator', '50.00'),
                        _buildListItems(
                            'assets/plate1.png', 'Calculator', '50.00'),
                        _buildListItems(
                            'assets/plate1.png', 'Calculator', '50.00'),
                        _buildListItems(
                            'assets/plate1.png', 'Phillips Kettle', '50.00'),
                        SizedBox(height: 30)
                      ]),
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

  Widget _buildListItems(String imgPath, String itemName, String price) {
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
                          heroTag: imgPath,
                          itemName: itemName,
                          itemPrice: price)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        child: Row(children: [
                      Hero(
                        tag: imgPath,
                        child: Image(
                          image: AssetImage(imgPath),
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
                            Text('Rs. ' + price,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 15.0,
                                    color: Colors.grey))
                          ])
                    ])),
                    IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.grey,
                        onPressed: () {})
                  ],
                ))));
  }
}
