import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:our_e_college_app/components/buysell/buySellDetails.dart';

class BuyList extends StatefulWidget {
  @override
  _BuyListState createState() => _BuyListState();
}

class _BuyListState extends State<BuyList> {
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
                  child: ListView(
                      children: [
                    _buildListItems('assets/1.jpg', 'M & G Book', '50.00'),
                    _buildListItems('assets/1.jpg', 'Maths II Book', '50.00'),
                    _buildListItems('assets/1.jpg', 'Calculator', '50.00'),
                    _buildListItems('assets/1.jpg', 'Calculator', '50.00'),
                    _buildListItems('assets/1.jpg', 'Calculator', '50.00'),
                    _buildListItems('assets/1.jpg', 'Calculator', '50.00'),
                    _buildListItems(
                        'assets/plate1.png', 'Phillips Kettle', '50.00'),
                    SizedBox(height: 30)
                  ]),
                ))),
      ),
    );
  }

  Widget _buildListItems(String imgPath, String itemName, String itemPrice) {
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
                      heroTag: imgPath,
                      itemName: itemName,
                      itemPrice: itemPrice)));
            },
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 2.5,
                      child: Image.asset(
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
                Positioned(
                  top: 8,
                  right: 8,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.heart,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
