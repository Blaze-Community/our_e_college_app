import 'dart:convert';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:our_e_college_app/components/classroom/classroom_helper.dart';
import 'package:our_e_college_app/components/classroom/create_join/create_class.dart';
import 'package:our_e_college_app/components/classroom/create_join/join_class.dart';
import 'package:our_e_college_app/components/classroom/data/classrooms.dart';
import 'package:our_e_college_app/global.dart' as Global;
import 'class_room_page.dart';
import 'package:http/http.dart' as http;

class ClassRoomHomePage extends StatefulWidget {
  @override
  _ClassRoomHomePageState createState() => _ClassRoomHomePageState();
}

class _ClassRoomHomePageState extends State<ClassRoomHomePage> {

  deleteClass(classId) async {
    var url = Uri.parse('http://localhost:5000/api/deleteClass');
    await http.delete(url,body: {"classId":classId}).then((response){
        print(json.decode(response.body));
        ClassRoomHelper.shared.fetchClassRoomlist("60d01593c1f3a30047498cac");
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    ClassRoomHelper.shared.fetchClassRoomlist("60d01593c1f3a30047498cac");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            StreamBuilder(
              stream: ClassRoomStreamControllerHelper.shared.classListStream,
              builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.active && ClassRoomHelper.loading == false){
                  if(snapshot.hasData){
                    List classRoomList = snapshot.data["classes"];
                    return  ListView.builder(
                        itemCount: classRoomList.length,
                        itemBuilder: (context, int index) {
                            return GestureDetector(
                              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => ClassRoomPage(
                                    classDetails:classRoomList[index],
                                    className: classRoomList[index]["subject"],
                                    bannerImg: classRoomDesingList[index]["bannerImg"],
                                  ))),
                              child: Container(
                                  height: 140,
                                  margin: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.orange,
                                      image: DecorationImage(
                                        image: classRoomDesingList[index]["bannerImg"],
                                        fit: BoxFit.cover,
                                      )
                                  ),
                                  child:Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  classRoomList[index]["subject"],
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    letterSpacing: 1,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons.copy,
                                                        color: Colors.white,
                                                      ),
                                                      splashColor: Colors.white54,
                                                      onPressed: () {
                                                        FlutterClipboard.copy(classRoomList[index]["enrolKey"])
                                                            .then(( value ) => print('copied'));

                                                      },
                                                      iconSize: 25,
                                                    ),
                                                    if(Global.user == "Teacher")
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color: Colors.white,
                                                        ),
                                                        splashColor: Colors.white54,
                                                        onPressed: () {
                                                          setState(() {
                                                            ClassRoomHelper.loading = true;
                                                          });
                                                          deleteClass(classRoomList[index]["_id"]);
                                                        },
                                                        iconSize: 25,
                                                      ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  classRoomList[index]["branch"],
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                                SizedBox(
                                                  width: 6,
                                                ),
                                                Text(
                                                  classRoomList[index]["section"],
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              classRoomList[index]["batch"],
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  letterSpacing: 1),
                                            ),
                                          ],
                                        ),

                                        Text("Created By: " +
                                            classRoomList[index]["createdBy"]["profileName"],
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white54,
                                              letterSpacing: 1),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                            );
                        });
                  }
                }
                return Center(child: CircularProgressIndicator());
              }
              ,
            ),
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
