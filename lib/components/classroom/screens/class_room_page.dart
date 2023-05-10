import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:our_e_college_app/components/classroom/screens/classroom/attendence_tab.dart';
import 'classroom/classwork_tab.dart';
import 'classroom/people_tab.dart';
import 'classroom/stream_tab.dart';

class ClassRoomPage extends StatefulWidget {
  AssetImage bannerImg;
  String className;
  final classDetails;
  //Color uiColor;

  ClassRoomPage({this.className, this.bannerImg,this.classDetails});

  @override
  _ClassRoomPage1State createState() => _ClassRoomPage1State();
}

class _ClassRoomPage1State extends State<ClassRoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Classroom"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                StreamTab(
                                    bannerImg: widget.bannerImg,
                                    className: widget.className,
                                    classDetails : widget.classDetails
                                )));
                  },
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0,0.0),
                          spreadRadius: 1,
                          blurRadius: 4
                        )
                      ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Image.asset("assets/stream.png")
                          ),
                          Text("Stream",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white
                          ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ClassWork(classDetails: widget.classDetails)));
                  },
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0,0.0),
                              spreadRadius: 1,
                              blurRadius: 4
                          )
                        ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Image.asset("assets/assignment.png")
                          ),
                          Text("ClassWork",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Attendence(classDetails: widget.classDetails)));
                  },
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0,0.0),
                              spreadRadius: 1,
                              blurRadius: 4
                          )
                        ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Image.asset("assets/attendence.png")
                          ),
                          Text("Attendence",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PeopleTab(classDetails: widget.classDetails)));
                  },
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0,0.0),
                              spreadRadius: 1,
                              blurRadius: 4
                          )
                        ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Image.asset("assets/people.png")
                          ),
                          Text("People",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}