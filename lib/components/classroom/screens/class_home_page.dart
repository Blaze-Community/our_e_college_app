import 'package:flutter/material.dart';
import 'package:our_e_college_app/components/classroom/create_join/create_class.dart';
import 'package:our_e_college_app/components/classroom/create_join/join_class.dart';
import 'package:our_e_college_app/components/classroom/data/classrooms.dart';
import 'package:our_e_college_app/global.dart' as Global;
import 'class_room_page.dart';

class ClassRoomHomePage extends StatefulWidget {
  @override
  _ClassRoomHomePageState createState() => _ClassRoomHomePageState();
}

class _ClassRoomHomePageState extends State<ClassRoomHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            ListView.builder(
              itemCount: classRoomList.length,
              itemBuilder: (context, int index) {
                return GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ClassRoomPage(
                            uiColor: classRoomList[index].uiColor,
                            className: classRoomList[index].className,
                            bannerImg: classRoomList[index].bannerImg,
                          ))),
                  child: Stack(
                    children: [
                      Container(
                        height: 140,
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.orange,
                        ),
                        child: Image(
                          image: classRoomList[index].bannerImg,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30, left: 30),
                        width: 220,
                        child: Text(
                          classRoomList[index].className,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 58, left: 30),
                        child: Text(
                          classRoomList[index].description,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              letterSpacing: 1),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 125, left: 30),
                        child: Text(
                          classRoomList[index].creator,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white54,
                              letterSpacing: 1),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, left: 370),
                        child: IconButton(
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                          splashColor: Colors.white54,
                          onPressed: () {},
                          iconSize: 25,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            Padding(
              // bottom: 10,
                padding: EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context){
                                if (Global.user == "Student") {
                                  return joinclass();
                                } else {
                                  return createclass();
                                }
                              }));
                    },
                    label: (Global.user == "Student")?Text('Join Class'):Text('Create Class'),
                    icon: Icon(Icons.add),
                  ),
                )),
        ]),
    );
  }
}
