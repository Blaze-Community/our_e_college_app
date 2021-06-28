import 'package:flutter/material.dart';
import 'package:our_e_college_app/components/classroom/classroom_helper.dart';
import 'package:our_e_college_app/components/result/newResult.dart';
import 'package:our_e_college_app/components/result/resultitem.dart';
import 'package:our_e_college_app/global-helper.dart';
import 'package:simple_moment/simple_moment.dart';

class Result extends StatefulWidget {
  final classDetails;
  Result({this.classDetails});
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {

  @override
  void initState() {
    ClassRoomHelper.shared.fetchClassInfo(widget.classDetails["_id"]);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top:12.0),
            child: Stack(
              children: [
                StreamBuilder(
                  stream: ClassRoomStreamControllerHelper.shared.classInfostream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active && GlobalHelper.loading == false) {
                      if (snapshot.hasData) {
                        final List items = snapshot.data["results"];
                        return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext ctxt, int i) {
                            return ResultItem(
                              id: items[i]["_id"],
                              classId: widget.classDetails["_id"],
                              title: items[i]["title"],
                              uploadDate: Moment.parse(items[i]["createdAt"]).format('dd-MM-yyyy'),
                              uri: items[i]["uri"],
                            );
                          },
                        );
                      }
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                if(GlobalHelper.userRole == "teacher")Padding(
                  // bottom: 10,
                    padding: EdgeInsets.only(bottom: 10),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      NewResult(classDetails: widget.classDetails,)));
                        },
                        label: Text('Add Result'),
                        icon: Icon(Icons.add),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
