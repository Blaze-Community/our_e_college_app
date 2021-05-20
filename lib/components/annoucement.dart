import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:our_e_college_app/utils/Theme.dart'as AppTheme;
class Annoucement extends StatefulWidget {
  @override
  _Annoucement createState() => _Annoucement();
}

class _Annoucement extends State<Annoucement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: EdgeInsets.only(top: 50.0),
        child: Container(
          height: 360.0,
          padding: EdgeInsets.only(bottom: 25.0),
          child:ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(left: 40.0, right: 40.0),
                scrollDirection: Axis.horizontal,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    color: Colors.red,
                    child: new Container(
                      width: 220.0,
                      //height: 100.0,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20.0, bottom: 15.0),
                              child: Container(
                                child: Text(
                                  "Hello",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19.0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 50.0),
                                      color: Colors.white,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsets.only(top: 30.0, left: 15.0, right: 5.0),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 220.0,
                                    child: ListView.builder(
                                      //physics: const NeverScrollableScrollPhysics(),
                                        itemCount: 1,
                                        itemBuilder: (BuildContext ctxt, int i) {
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Icon(
                                                FontAwesomeIcons.checkCircle,
                                                color: Colors.white,
                                                size: 14.0,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: 10.0),
                                              ),
                                              Flexible(
                                                child: Text("Nice One",
                                                    style:TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: Colors.white70,
                                                      fontSize: 17.0,
                                                    )
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    color: Colors.orange,
                    child: new Container(
                      width: 220.0,
                      //height: 100.0,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20.0, bottom: 15.0),
                              child: Container(
                                child: Text(
                                  "Hello",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19.0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 50.0),
                                      color: Colors.white,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsets.only(top: 30.0, left: 15.0, right: 5.0),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 220.0,
                                    child: ListView.builder(
                                      //physics: const NeverScrollableScrollPhysics(),
                                        itemCount: 1,
                                        itemBuilder: (BuildContext ctxt, int i) {
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Icon(
                                                FontAwesomeIcons.checkCircle,
                                                color: Colors.white,
                                                size: 14.0,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: 10.0),
                                              ),
                                              Flexible(
                                                child: Text("Nice One",
                                                    style:TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: Colors.white70,
                                                      fontSize: 17.0,
                                                    )
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    color: Colors.green,
                    child: new Container(
                      width: 220.0,
                      //height: 100.0,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20.0, bottom: 15.0),
                              child: Container(
                                child: Text(
                                  "Hello",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19.0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 50.0),
                                      color: Colors.white,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsets.only(top: 30.0, left: 15.0, right: 5.0),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 220.0,
                                    child: ListView.builder(
                                      //physics: const NeverScrollableScrollPhysics(),
                                        itemCount: 1,
                                        itemBuilder: (BuildContext ctxt, int i) {
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Icon(
                                                FontAwesomeIcons.checkCircle,
                                                color: Colors.white,
                                                size: 14.0,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: 10.0),
                                              ),
                                              Flexible(
                                                child: Text("Nice One",
                                                    style:TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: Colors.white70,
                                                      fontSize: 17.0,
                                                    )
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    color: AppTheme.Colors.flatOrange,
                    child: new Container(
                      width: 220.0,
                      //height: 100.0,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20.0, bottom: 15.0),
                              child: Container(
                                child: Text(
                                  "Hello",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19.0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 50.0),
                                      color: Colors.white,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsets.only(top: 30.0, left: 15.0, right: 5.0),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 220.0,
                                    child: ListView.builder(
                                      //physics: const NeverScrollableScrollPhysics(),
                                        itemCount: 1,
                                        itemBuilder: (BuildContext ctxt, int i) {
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Icon(
                                                FontAwesomeIcons.checkCircle,
                                                color: Colors.white,
                                                size: 14.0,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: 10.0),
                                              ),
                                              Flexible(
                                                child: Text("Nice One",
                                                    style:TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: Colors.white70,
                                                      fontSize: 17.0,
                                                    )
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ),
        ),
      );

  }
}