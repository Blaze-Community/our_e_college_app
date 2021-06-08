import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:our_e_college_app/components/timetable/timetableitems.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

class TimeTable extends StatefulWidget {
  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  String month, year;
  Future<String> getTimetable() async {
    User user = FirebaseAuth.instance.currentUser;
    var uid = user.uid;
    var student;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        student = documentSnapshot.data();
      } else {
        print('Document does not exist on the user database');
      }
    });
    return await FirebaseFirestore.instance
        .collection('Batch')
        .doc(student["batch"])
        .collection('Branch')
        .doc(student["branch"])
        .collection('Section')
        .doc(student["section"])
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return documentSnapshot["timetable"];
      } else {
        print('Document does not exist on the timetable database');
      }
    });
  }

  Future fetchTimetable(http.Client client) async {
    final timeTableUri = await getTimetable();
    final response = await client.get(Uri.parse(timeTableUri));
    return parseTimetable(response.body);
  }

  Map<String, List<TimeTableItems>> parseTimetable(String str) {
    return Map.from(json.decode(str)).map((k, v) => MapEntry<String,
            List<TimeTableItems>>(k,
        List<TimeTableItems>.from(v.map((x) => TimeTableItems.fromJson(x)))));
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
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
                                  text: " ${selectedDay.year.toString()}",
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
                              firstDay: DateTime.utc(2010, 10, 16),
                              lastDay: DateTime.utc(2030, 3, 14),
                              focusedDay: selectedDay,
                              onDaySelected:
                                  (DateTime selectDay, DateTime focusDay) {
                                setState(() {
                                  selectedDay = selectDay;
                                });
                              },
                              onFormatChanged: (format) {
                                if (_calendarFormat != format) {
                                  // Call `setState()` when updating calendar format
                                  setState(() {
                                    _calendarFormat = format;
                                  });
                                }
                              },
                              holidayPredicate: (DateTime day) {
                                return DateTime.sunday == day.weekday ||
                                    DateTime.saturday == day.weekday;
                              },
                              calendarFormat: _calendarFormat,
                              headerVisible: false,
                              selectedDayPredicate: (DateTime day) {
                                return isSameDay(selectedDay, day);
                              },
                              calendarStyle: CalendarStyle(
                                  isTodayHighlighted: true,
                                  selectedDecoration: BoxDecoration(
                                      color: Colors.orange,
                                      shape: BoxShape.circle),
                                  holidayTextStyle:
                                      TextStyle(color: Colors.white),
                                  holidayDecoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle)),
                            )
                          ])),
                      FutureBuilder(
                        future: fetchTimetable(http.Client()),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            //print("data ${snapshot.data[selectedDay.weekday.toString()].length}");
                            if (selectedDay.weekday == 6 ||
                                selectedDay.weekday == 7) {
                              return Expanded(child: ListView());
                            } else {
                              return Expanded(
                                child: ListView.builder(
                                  itemCount: snapshot
                                      .data[selectedDay.weekday.toString()]
                                      .length,
                                  itemBuilder: (context, i) {
                                    return TimeTableItems(
                                        subject: snapshot
                                            .data[selectedDay.weekday
                                                .toString()][i]
                                            .subject,
                                        time: snapshot
                                            .data[selectedDay.weekday
                                                .toString()][i]
                                            .time,
                                        room: snapshot
                                            .data[selectedDay.weekday
                                                .toString()][i]
                                            .room);
                                  },
                                ),
                              );
                            }
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          // By default, show a loading spinner.
                          return CircularProgressIndicator();
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
