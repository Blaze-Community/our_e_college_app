import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:our_e_college_app/components/classroom/classroom_helper.dart';
import 'package:our_e_college_app/components/classroom/data/comments.dart';
import 'package:our_e_college_app/components/classroom/widgets/profile_tile.dart';

import '../../../../global-helper.dart';

class PeopleTab extends StatefulWidget {
  final classDetails;
  PeopleTab({this.classDetails});

  @override
  _PeopleTabState createState() => _PeopleTabState();
}

class _PeopleTabState extends State<PeopleTab> {

  @override
  void initState() {
    // TODO: implement initState
    ClassRoomHelper.shared.fetchClassInfo(widget.classDetails["_id"]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 30, left: 15, bottom: 10),
          child: Text(
            "Teachers",
            style: TextStyle(
                fontSize: 30, color: Colors.redAccent, letterSpacing: 1),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15),
          width: MediaQuery.of(context).size.width - 30,
          height: 2,
          color: Colors.redAccent,
        ),
        StreamBuilder(
            stream: ClassRoomStreamControllerHelper.shared.classInfostream,
            builder:(context,snapshot){
              if(snapshot.connectionState == ConnectionState.active && GlobalHelper.loading == false){
                if(snapshot.hasData){
                  var item = snapshot.data["createdBy"];
                  return Profile(
                          name: item["profileName"],
                          uri: item["profilePhotoUri"],
                  );
                }
              }
              return Center(child: CircularProgressIndicator());
            }),
        SizedBox(width: 30),
        Container(
          padding: EdgeInsets.only(top: 30, left: 15, bottom: 10),
          child: Text(
            "Classmates",
            style: TextStyle(
                fontSize: 30, color: Colors.redAccent, letterSpacing: 1),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15),
          width: MediaQuery.of(context).size.width - 30,
          height: 2,
          color: Colors.redAccent,
        ),
        StreamBuilder(
            stream: ClassRoomStreamControllerHelper.shared.classInfostream,
            builder:(context,snapshot){
              if(snapshot.connectionState == ConnectionState.active && GlobalHelper.loading == false){
                if(snapshot.hasData){
                  var item = snapshot.data["enrollStudents"];
                  return Expanded(
                      child: ListView.builder(
                          itemCount: item.length,
                          itemBuilder: (context, int index) {
                            return Profile(
                              uri: item[index]["profilePhotoUri"],
                              name: item[index]["profileName"],
                            );
                          }));
                }
              }
              return Center(child: CircularProgressIndicator());
            })
      ],
    );
  }
}
