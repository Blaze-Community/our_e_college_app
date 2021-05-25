import 'package:flutter/material.dart';
import 'package:our_e_college_app/utils/buyList.dart';
import 'package:our_e_college_app/utils/sellList.dart';

class BuySell extends StatefulWidget {
  @override
  _BuySellState createState() => _BuySellState();
}

class _BuySellState extends State<BuySell> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2, 
        child: Scaffold(
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
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Buy",
                ),
                Tab(
                  text: "Sell",
                )
              ],
            ),
            title: Text('Buy / Sell',
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
          backgroundColor: Colors.deepPurple,
          body: TabBarView(
            children: [
              BuyList(),
              SellList(),
            ],
          ),
        )
      );
  }
}
