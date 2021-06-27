import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:our_e_college_app/components/classroom/widgets/comment_composer.dart';
import 'package:our_e_college_app/global.dart' as Global;
import 'package:our_e_college_app/components/classroom/classroom_helper.dart';
import 'package:http/http.dart' as http;
import 'package:simple_moment/simple_moment.dart';

class StreamTab extends StatefulWidget {
  final AssetImage bannerImg;
  final String className;
  final classDetails;

  StreamTab({this.bannerImg, this.className, this.classDetails});

  @override
  _StreamTabState createState() => _StreamTabState();
}

class _StreamTabState extends State<StreamTab> {
  final message_for_class = TextEditingController();
  uploadMessage() async {
    var url = Uri.parse('http://localhost:5000/api/uploadMessage');
    await http.post(url, body: {
      "classId": widget.classDetails["_id"],
      "message": message_for_class.text
    }).then((response) {
      ClassRoomHelper.shared.fetchClassInfo(widget.classDetails["_id"]);
      final responseJson = json.decode(response.body);
      message_for_class.text = "";
      print(responseJson);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    ClassRoomHelper.shared.fetchClassInfo(widget.classDetails["_id"]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 120,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Image(
                  image: widget.bannerImg,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: 200,
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(bottom: 40, left: 30),
                child: Text(
                  widget.className,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )
            ],
          ),
        ),
        if (Global.user != "Student")
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextFormField(
                controller: message_for_class,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Send Message",
                  suffixIcon: InkWell(
                      child: Icon(
                        Icons.send,
                        color: Colors.deepOrange,
                      ),
                      onTap: () {
                        print("send message");
                        setState(() {
                          ClassRoomHelper.loading = true;
                        });
                        uploadMessage();
                      }),
                )),
          ),
        Expanded(
          child: StreamBuilder(
            stream: ClassRoomStreamControllerHelper.shared.classInfostream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  final List items = snapshot.data["classInfo"]["messages"];
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext ctxt, int i) {
                      return CommentComposer(
                        classId: widget.classDetails["_id"],
                        id: items[i]["_id"],
                        date: Moment.parse(items[i]["createdAt"])
                            .format('dd-MM-yyyy'),
                        message: items[i]["message"],
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
        )
      ],
    );
  }
}
