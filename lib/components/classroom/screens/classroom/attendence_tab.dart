import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:our_e_college_app/components/attendence/attendenceItem.dart';
import 'package:our_e_college_app/components/classroom/classroom_helper.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

import '../../../../global-helper.dart';

class Attendence extends StatefulWidget {
  final classDetails;
  Attendence({this.classDetails});

  @override
  _AttendenceState createState() => _AttendenceState();
}

class _AttendenceState extends State<Attendence> {
  DateTime selectedDay = DateTime.now();
  var attendenceList;
  String selectedDate;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  List month = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEP",
    "OCT",
    "NOV",
    "DEC"
  ];
  Future refresh() async {
    String url = 'https://college-app-backend-production.up.railway.app/api/refresh';
    final storage = new FlutterSecureStorage();
    final refreshToken = await storage.read(key: "refreshToken");
    //final refreshToken = GlobalHelper.refreshToken;
    final body = json.encode({"token": refreshToken});
    final response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: body);
    if(response.statusCode == 200){
      final responseJson = json.decode(response.body);
      if (responseJson['msg'] == "Refresh token expired, Please Login again!") {
        Fluttertoast.showToast(
            msg: "Refresh token expired, Please Login again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        // refresh token expired, show dailogue that says user to login again.
        print("Refresh token expired, please login again");
      }
      final accessToken = responseJson['accessToken'];
      await storage.write(key: "accessToken", value: accessToken);
      // GlobalHelper.accessToken = accessToken;
    }
    else{
      print(json.decode(response.body)["msg"]);
    }
  }

  Future<dynamic> checkAccessToken() async {
    final storage = new FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");
    //final accessToken = GlobalHelper.accessToken;

    var url = 'https://college-app-backend-production.up.railway.app/api/updateAttendence';
    Map body =  {
      "classId": widget.classDetails["_id"],
      "list": attendenceList,
      "date":selectedDate
    };
    final response = await http.post(Uri.parse(url),
        headers: {
          "Authorization": "Bearer $accessToken",
          "Content-Type": "application/json",
        },
        body: json.encode(body));
    try{
      if(response.statusCode == 200){
        print("Success!");
        Fluttertoast.showToast(
            msg: "Success!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return json.decode(response.body);
      }
      else{
        Fluttertoast.showToast(
            msg: "ERROR!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        print(json.decode(response.body)["msg"]);
      }
    }
    catch(err){
      print(err);
    }
  }
  uploadAttendence() async {
    var responseJson = await checkAccessToken();
    if (responseJson['msg'] == "Access token expired") {
      await refresh();
      responseJson = await checkAccessToken();
    }
    if (responseJson['success'] == true) {
      ClassRoomHelper.shared.fetchClassAttendence(widget.classDetails["_id"],selectedDate);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    selectedDate = Moment.parse(selectedDay.toString()).format('dd-MM-yyyy');
    if(GlobalHelper.userRole == "teacher")
      ClassRoomHelper.shared.fetchClassAttendence(widget.classDetails["_id"],selectedDate);
    else
      ClassRoomHelper.shared.fetchClassStudentAttendence(widget.classDetails["_id"]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Attendence"),
        ),
        body: Container(
          alignment: Alignment.topCenter,
          color: Color(0xFFF0F0F0),
          child: (GlobalHelper.userRole == "teacher")?
            Column(
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
                              text: month[selectedDay.month - 1],
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
                    InkWell(
                      onTap: (){
                        setState(() {
                          GlobalHelper.loading = true;
                        });
                        uploadAttendence();
                      },
                      child: Text("Save",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.deepOrange
                      ),),
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
                                  firstDay: DateTime.utc(DateTime.parse(widget.classDetails["createdAt"]).year,DateTime.parse(widget.classDetails["createdAt"]).month, DateTime.parse(widget.classDetails["createdAt"]).day),
                                  lastDay: DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                                  focusedDay: selectedDay,
                                  onDaySelected:
                                      (DateTime selectDay, DateTime focusDay) {
                                    setState(() {
                                      selectedDay = selectDay;
                                      GlobalHelper.loading = true;
                                      selectedDate = Moment.parse(selectedDay.toString()).format('dd-MM-yyyy');
                                      ClassRoomHelper.shared.fetchClassAttendence(widget.classDetails["_id"],selectedDate);
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
                              Container(
                                height:40,
                                color: Colors.lightBlueAccent,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Enrollment No.",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                      ),),
                                      Text("Present",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                        ),),
                                      Text("Absent",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                        ),)
                                    ],
                                  ),
                                ),
                              ),
                                  StreamBuilder(
                                    stream: ClassRoomStreamControllerHelper.shared.classAttendenceStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.active && GlobalHelper.loading == false) {
                                        if (snapshot.hasData) {
                                          attendenceList = snapshot.data;
                                          return Expanded(
                                            child: ListView.builder(
                                              itemCount: attendenceList.length,
                                              itemBuilder: (context, i) {
                                                return Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                                  child: Container(
                                                    color: Colors.white,
                                                    height: 50,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(attendenceList[i]["student"]["rollno"],
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            ),),
                                                          InkWell(
                                                            onTap: (){
                                                              setState(() {
                                                                if(attendenceList[i]["absent"]==true) {
                                                                  attendenceList[i]["absent"] = false;
                                                                }
                                                                attendenceList[i]["present"] = true;
                                                              });

                                                            },
                                                            splashColor: Colors.green,
                                                            child: Icon(
                                                                Icons.check_circle_outline,
                                                                size: 40,
                                                                color: (attendenceList[i]["present"]==true)?Colors.green:Colors.grey
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: (){
                                                              setState(() {
                                                                if(attendenceList[i]["present"]==true) {
                                                                  attendenceList[i]["present"] = false;
                                                                }
                                                                attendenceList[i]["absent"] = true;
                                                              });
                                                            },
                                                            splashColor: Colors.red,
                                                            child: Icon(
                                                                Icons.circle,
                                                                size: 40,
                                                                color: (attendenceList[i]["absent"]==true)?Colors.red:Colors.grey
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        }
                                      }
                                      return Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    },
                                  )
                    ],
                  ),
                ),
              )
            ],
          ):
          StreamBuilder(
              stream: ClassRoomStreamControllerHelper.shared.classStudentAttendenceStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active && GlobalHelper.loading == false) {
                  if (snapshot.hasData) {
                    var items = snapshot.data;
                    return Column(
                      children: [
                        AttendenceItem(
                            subject: widget.classDetails["subject"],
                            attend: items.length,
                            totalClasses: widget.classDetails["attendence"].length,
                            primaryColor: Color(0xFF2633C5),
                            secondaryColor: HexColor("#8A98E8")),
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
                                Container(
                                  height:40,
                                  color: Colors.lightBlueAccent,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Date",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold
                                          ),),
                                        Text("Present",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                          ),),
                                        Text("Absent",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                          ),)
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: items.length,
                                    itemBuilder: (context, i) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                        child: Container(
                                          color: Colors.white,
                                          height: 50,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(Moment.parse(items[i]["date"]).format('dd-MM-yyyy'),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),),
                                                Icon(
                                                    Icons.check_circle_outline,
                                                    size: 40,
                                                    color: items[i]["present"]==true?Colors.green:Colors.grey
                                                ),
                                                Icon(
                                                    Icons.circle,
                                                    size: 40,
                                                    color: items[i]["absent"]==true?Colors.red:Colors.grey
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                                // StreamBuilder(
                                //   stream: ClassRoomStreamControllerHelper.shared.classAttendenceStream,
                                //   builder: (context, snapshot) {
                                //     if (snapshot.connectionState == ConnectionState.active && GlobalHelper.loading == false) {
                                //       if (snapshot.hasData) {
                                //         attendenceList = snapshot.data;
                                //         return ;
                                //       }
                                //     }
                                //     return Padding(
                                //       padding: const EdgeInsets.all(16.0),
                                //       child: Center(
                                //         child: CircularProgressIndicator(),
                                //       ),
                                //     );
                                //   },
                                // )
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
        ));
  }
}
