import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:our_e_college_app/components/timetable/timetableitems.dart';
import 'package:table_calendar/table_calendar.dart';

class TimeTable extends StatefulWidget {
  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  String month, year;
  Map<int, List> events = {
    1: [
      {"Subject": "Data Structure", "Time": "07:00", "Room": "402"},
      {"Subject": "Operating System", "Time": "08:00", "Room": "404"},
      {"Subject": "Digital Signals", "Time": "10:00", "Room": "406"},
      {"Subject": "Maths", "Time": "12:00", "Room": "402"},
      {"Subject": "Deep Learning", "Time": "15:00", "Room": "305"},
      {"Subject": "Applied Science", "Time": "17:00", "Room": "402"}
    ],
    2: [
      {"Subject": "Data Structure", "Time": "07:00", "Room": "402"},
      {"Subject": "Operating System", "Time": "08:00", "Room": "404"},
      {"Subject": "Digital Signals", "Time": "10:00", "Room": "406"},
      {"Subject": "Applied Science", "Time": "12:00", "Room": "402"},
      {"Subject": "Deep Learning", "Time": "15:00", "Room": "305"},
      {"Subject": "Maths", "Time": "17:00", "Room": "402"}
    ],
    3: [
      {"Subject": "Operating System", "Time": "07:00", "Room": "402"},
      {"Subject": "Digital Signals", "Time": "08:00", "Room": "404"},
      {"Subject": "Data Structure", "Time": "10:00", "Room": "406"},
      {"Subject": "Maths", "Time": "12:00", "Room": "402"},
      {"Subject": "Deep Learning", "Time": "15:00", "Room": "305"},
      {"Subject": "Applied Science", "Time": "17:00", "Room": "402"}
    ],
    4: [
      {"Subject": "Operating System", "Time": "07:00", "Room": "402"},
      {"Subject": "Digital Signals", "Time": "08:00", "Room": "404"},
      {"Subject": "Deep Learning", "Time": "10:00", "Room": "406"},
      {"Subject": "Maths", "Time": "12:00", "Room": "402"},
      {"Subject": "Data Structure", "Time": "15:00", "Room": "305"},
      {"Subject": "Applied Science", "Time": "17:00", "Room": "402"}
    ],
    5: [
      {"Subject": "Data Structure", "Time": "07:00", "Room": "402"},
      {"Subject": "Operating System", "Time": "08:00", "Room": "404"},
      {"Subject": "Digital Signals", "Time": "10:00", "Room": "406"},
      {"Subject": "Applied Science", "Time": "12:00", "Room": "402"},
      {"Subject": "Deep Learning", "Time": "15:00", "Room": "305"},
      {"Subject": "Maths", "Time": "17:00", "Room": "402"}
    ],
  };
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
                              focusedDay: DateTime.now(),
                              onDaySelected:
                                  (DateTime selectDay, DateTime focusDay) {
                                setState(() {
                                  selectedDay = selectDay;
                                });
                                print(events[selectedDay.weekday]);
                              },
                              calendarFormat: CalendarFormat.week,
                              headerVisible: false,
                              selectedDayPredicate: (DateTime day) {
                                return isSameDay(selectedDay, day);
                              },
                              calendarStyle: CalendarStyle(
                                  isTodayHighlighted: true,
                                  selectedDecoration: BoxDecoration(
                                      color: Colors.orange,
                                      shape: BoxShape.circle)),
                            )
                          ])),
                      Expanded(
                        child: ListView(
                          children: [
                            for (int i = 0;
                                i < events[selectedDay.weekday].length;
                                i++)
                              TimeTableItems(
                                  subject: events[selectedDay.weekday][i]
                                      ["Subject"],
                                  time: events[selectedDay.weekday][i]["Time"],
                                  room: events[selectedDay.weekday][i]["Room"])
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
