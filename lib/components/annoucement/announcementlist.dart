import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class AnnouncementList extends StatefulWidget {
  String title;
  List announcementList;

  AnnouncementList({
    this.title,
    this.announcementList,
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
        body: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    //physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.announcementList.length,
                    itemBuilder: (BuildContext ctxt, int i) {
                      return buildTaskListItem(
                          widget.announcementList[i]["title"], widget.announcementList[i]["link"]);
                    }),
              )
            ],
          ),
        ));
  }

  Container buildTaskListItem(String announcement, String link) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: Column(
        children: [
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
                children: [
                  Expanded(
                    child: Text(
                      announcement,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      bool _validURL = Uri.parse(link).isAbsolute;
                      if(_validURL == true){
                        await launch(link);
                      }
                      else{
                        await launch("https://iiitn.ac.in/"+link);
                      }
                    },
                    child: Text(
                      "Read More",
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
