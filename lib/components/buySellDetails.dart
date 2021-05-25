import 'package:flutter/material.dart';

class BuySellDetails extends StatefulWidget {
  final heroTag;
  final itemName;
  final itemPrice;

  BuySellDetails({this.heroTag, this.itemName, this.itemPrice});
  @override
  _BuySellDetailsState createState() => _BuySellDetailsState();
}

class _BuySellDetailsState extends State<BuySellDetails> {
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
          title: Text(widget.itemName,
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
                    width: MediaQuery.of(context).size.width)),
            // SizedBox(height: 40),
            Positioned(
                top: 30.0,
                left: (MediaQuery.of(context).size.width / 2) - 100.0,
                child: Hero(
                    tag: widget.heroTag,
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(widget.heroTag),
                                fit: BoxFit.cover)),
                        height: 200.0,
                        width: 200.0))),
            Positioned(
                top: 400.0,
                left: 25.0,
                right: 25.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.itemName,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Rs. ' + widget.itemPrice,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 20.0,
                                color: Colors.grey)),
                        // Container(height: 25.0, color: Colors.grey, width: 1.0),
                        // Container(
                        //   width: 125.0,
                        //   height: 40.0,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(17.0),
                        //       color: Color(0xFF7A9BEE)),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: <Widget>[
                        //       InkWell(
                        //         onTap: () {},
                        //         child: Container(
                        //           height: 25.0,
                        //           width: 25.0,
                        //           decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(7.0),
                        //               color: Color(0xFF7A9BEE)),
                        //           child: Center(
                        //             child: Icon(
                        //               Icons.remove,
                        //               color: Colors.white,
                        //               size: 20.0,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       Text('2',
                        //           style: TextStyle(
                        //               color: Colors.white,
                        //               fontFamily: 'Montserrat',
                        //               fontSize: 15.0)),
                        //       InkWell(
                        //         onTap: () {},
                        //         child: Container(
                        //           height: 25.0,
                        //           width: 25.0,
                        //           decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(7.0),
                        //               color: Colors.white),
                        //           child: Center(
                        //             child: Icon(
                        //               Icons.add,
                        //               color: Color(0xFF7A9BEE),
                        //               size: 20.0,
                        //             ),
                        //           ),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                    SizedBox(height: 40.0),
                    Container(
                      // height: 200.0,
                      child: _buildContactDetails('Ashish Sonam', 'C-21', '8210864839'),
                    ),
                    // SizedBox(height: 20.0),
                  ],
                ))
          ])
        ]));
  }

  Widget _buildContactDetails(String name, String roomNo, String contactNo) {
    return Container(
              // height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey[300]),
                  borderRadius: BorderRadius.circular(20),
                  // color: Colors.purple[300],
                  ),
              // margin: EdgeInsets.only(right: 5, left: 5),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Contact Details",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(width: 40.0, color: Colors.grey, height: 1.0),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Name: ',
                                style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                name,
                                style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                'Room No.: ',
                                style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                roomNo,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                'Contact No.: ',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey
                                ),
                              ),
                              Text(
                                contactNo,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),

                            ],
                          )
                        ],
                      ),
                      OutlinedButton(
                        onPressed: () {},

                        child: Text(
                          "CALL",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      )
                ],
              ),
                ],
              )
            );
    // return InkWell(
    //   onTap: () {
    //     // selectCard(cardTitle);
    //   },
    //   child: AnimatedContainer(
    //     duration: Duration(milliseconds: 500),
    //     curve: Curves.easeIn,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(10.0),
    //       color: Colors.deepPurple,
    //       border: Border.all(
    //         color: Colors.transparent,
    //         style: BorderStyle.solid,
    //       width: 0.75
    //       ),

    //     ),
    //     height: 100.0,
    //     width: 100.0,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.only(top: 8.0, left: 15.0),
    //           child: Text(cardTitle,
    //               style: TextStyle(
    //                 fontFamily: 'Montserrat',
    //                 fontSize: 12.0,
    //                 color: Colors.white,
    //               )),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //               Text(info,
    //                   style: TextStyle(
    //                       fontFamily: 'Montserrat',
    //                       fontSize: 14.0,
    //                       color: Colors.white,
    //                       fontWeight: FontWeight.bold)),
    //               Text(unit,
    //                   style: TextStyle(
    //                     fontFamily: 'Montserrat',
    //                     fontSize: 12.0,
    //                     color: Colors.white
    //                   ))
    //             ],
    //           ),
    //         )
    //       ]
    //     )
    //   )
    // );
  }
}
