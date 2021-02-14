import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TimeTable extends StatefulWidget {
  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            height: double.infinity,
            child: Column(children: [
              Container(
                  height: 35,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 1.0,
                          )
                        ]),
                        child: Text(
                          "Monday",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: 150.0,
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 1.0,
                          )
                        ]),
                        child: Text(
                          "Tuesday",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: 150.0,
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 1.0,
                          )
                        ]),
                        child: Text(
                          "Wednesday",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: 150.0,
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 1.0,
                          )
                        ]),
                        child: Text(
                          "Thursday",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: 150.0,
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 1.0,
                          )
                        ]),
                        child: Text(
                          "Friday",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )),
              TimeTableBox(
                  subject: "English", room: "102", time: "9:00am - 9:55am"),
              TimeTableBox(
                  subject: "Godzilla", room: "105", time: "10:00am - 10:55am"),
              TimeTableBox(
                  subject: "Maths", room: "101", time: "12:00pm - 12:55pm"),
            ])));
  }
}

class TimeTableBox extends StatelessWidget {
  final String subject;
  final String room;
  final String time;

  TimeTableBox({this.subject, this.room, this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 5.0,
              spreadRadius: 2.0,
            )
          ]),
      child: Column(
        children: [
          Text(
            subject,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Time",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(time),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Room",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(room),
                ],
              ),
            ],
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 15, left: 15, right: 15),
      padding: EdgeInsets.only(top: 15),
    );
  }
}
