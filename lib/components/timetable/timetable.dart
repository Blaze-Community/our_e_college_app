import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:our_e_college_app/components/timetable/timetableitems.dart';
import 'package:table_calendar/table_calendar.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class TimeTable extends StatefulWidget {
  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  CalendarController _controller;
  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TimeTable"),
        ),
        body: Container(
          alignment: Alignment.topCenter,
          color: Color(0xFFF0F0F0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.grey),
                        SizedBox(
                          width: 15,
                        ),
                        RichText(
                          text: TextSpan(
                              text: "May",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0XFF263064),
                                fontSize: 22,
                              ),
                              children: [
                                TextSpan(
                                  text: " 2021",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                    Text(
                      "CSE Batch - A",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF3E3993),
                          fontSize: 16),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                            height: 15,
                            ),
                            TableCalendar(
                              calendarController: _controller,
                              initialCalendarFormat: CalendarFormat.week,
                              headerVisible: false,
                            // calendarStyle: CalendarStyle(todayStyle: ),
                            )
                          ]
                        )
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            TimeTableItems(
                              subject: "Software Engenring",
                              time: "07:00",
                              room: "class 401",
                            ),
                            TimeTableItems(
                              subject: "Operating System",
                              time: "08:00",
                              room: "class 401",
                            ),
                            TimeTableItems(
                              subject: "Object Oriented Programming",
                              time: "09:00",
                              room: "class 401",
                            ),
                            TimeTableItems(
                              subject: "Data Structure",
                              time: "11:00",
                              room: "class 401",
                            ),
                            TimeTableItems(
                              subject: "Digital Signals",
                              time: "13:00",
                              room: "class 407",
                            ),
                            TimeTableItems(
                              subject: "Cloud computing",
                              time: "15:00",
                              room: "class 404",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )

            ],
          ),
          /*child: Container(
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
                          TimeTableItems(
                            subject: "Software Engenring",
                            time: "07:00",
                            room: "class 401",
                          ),
                          TimeTableItems(
                            subject: "Operating System",
                            time: "08:00",
                            room: "class 401",
                          ),
                          TimeTableItems(
                            subject: "Object Oriented Programming",
                            time: "09:00",
                            room: "class 401",
                          ),
                          TimeTableItems(
                            subject: "Data Structure",
                            time: "11:00",
                            room: "class 401",
                          ),
                          TimeTableItems(
                            subject: "Digital Signals",
                            time: "13:00",
                            room: "class 407",
                          ),
                          TimeTableItems(
                            subject: "Cloud computing",
                            time: "15:00",
                            room: "class 404",
                          ),
                        ]
                      ),
                    ))),
          ),*/
        )
        );
  }
}
