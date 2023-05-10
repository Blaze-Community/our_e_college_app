import 'package:flutter/material.dart';
import 'package:our_e_college_app/components/report_bully/upload_video.dart';

import './result.dart';

class ReportBully extends StatefulWidget {

  @override
  _ReportBullyState createState() => _ReportBullyState();
}

class _ReportBullyState extends State<ReportBully> {
  @override
  Widget build(BuildContext context) {
    final tabs = [
      UploadVideo(),
      Result()
    ];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Report Bully",
              style: TextStyle(
                  color: Colors.deepOrange
              ),),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back),
              color: Colors.deepOrange,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            bottom: TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.deepOrange,
              tabs: [
                Tab(
                  text: "Upload",
                ),
                Tab(
                  text: "Result",
                ),
              ],
            ),
          ),
          // backgroundColor: Colors.deepPurple,
          body: TabBarView(
            children:tabs,)
      ),
    );
  }
}