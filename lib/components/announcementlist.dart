import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AnnouncementList extends StatefulWidget {
  String title;
  List<List> announcement;

  AnnouncementList({
    this.title,
    this.announcement,

  });
  @override
  _AnnouncementListState createState() => _AnnouncementListState();
}

class _AnnouncementListState extends State<AnnouncementList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
        body: Container(
          height: MediaQuery.of(context).size.height - 100,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [

              Expanded(
                child: ListView.builder(
                  //physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.announcement.length,
                    itemBuilder: (BuildContext ctxt, int i) {
                      return buildTaskListItem(widget.announcement[i][0], widget.announcement[i][1]);
                    }),
              )
            ],
          ),
        ));
  }

  Container buildTaskListItem(String classSubject, String classTime) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 15,
                height: 10,
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(5),
                    )),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: classTime,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: " AM",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                            )
                          ]),
                    ),

                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 90,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey[300]),
                borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.only(right: 10, left: 30),
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                  Expanded(
                    child: Text(

                      classSubject,

                      style: TextStyle(

                        fontSize: 15,
                      ),
                    ),
                  ),

                OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    "READ MORE",
                    style: TextStyle(
                      // color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}