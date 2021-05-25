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
                    width: MediaQuery.of(context).size.width)),
            // SizedBox(height: 40),
            // Positioned(
            //     top: 30.0,
            //     left: (MediaQuery.of(context).size.width / 2) - 100.0,
            //     child: Hero(
            //         tag: widget.heroTag,
            //         child: Container(
            //             decoration: BoxDecoration(
            //                 image: DecorationImage(
            //                     image: AssetImage(widget.heroTag),
            //                     fit: BoxFit.cover)),
            //             height: 200.0,
            //             width: 200.0))),
            // Positioned(
            //     top: 400.0,
            //     left: 25.0,
            //     right: 25.0,
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: <Widget>[
            //         Text(widget.itemName,
            //             style: TextStyle(
            //                 fontFamily: 'Montserrat',
            //                 fontSize: 22.0,
            //                 fontWeight: FontWeight.bold)),
            //         SizedBox(height: 20.0),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: <Widget>[
            //             Text('Rs. ' + widget.itemPrice,
            //                 style: TextStyle(
            //                     fontFamily: 'Montserrat',
            //                     fontSize: 20.0,
            //                     color: Colors.grey)),
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
                    // SizedBox(height: 40.0),
                    // Container(
                    //   // height: 200.0,
                    //   child: _buildContactDetails(
                    //       'Ashish Sonam', 'C-21', '8210864839'),
                    // ),
                    // SizedBox(height: 20.0),
                  ],
                ));
  }
}
