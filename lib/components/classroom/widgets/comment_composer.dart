import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:our_e_college_app/global.dart' as Global;
import 'package:http/http.dart' as http;
import 'package:our_e_college_app/components/classroom/classroom_helper.dart';

class CommentComposer extends StatefulWidget {
  final String id;
  final String message;
  final String date;
  final String classId;
  CommentComposer({this.classId, this.id, this.date, this.message});
  @override
  _CommentComposerState createState() => _CommentComposerState();
}

class _CommentComposerState extends State<CommentComposer> {
  deleteMessage() async {
    var url = Uri.parse('http://localhost:5000/api/deleteMessage');
    await http.delete(url,
        body: {"classId": widget.classId, "msgId": widget.id}).then((response) {
      ClassRoomHelper.shared.fetchClassInfo(widget.classId);
      final responseJson = json.decode(response.body);
      print(responseJson);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        padding: EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.deepOrange),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Dated : ${widget.date}",
                  style: TextStyle(color: Colors.black),
                )),
                if (Global.user != "Student")
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      deleteMessage();
                    },
                  )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Message - ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
                width: MediaQuery.of(context).size.width - 40,
                margin: EdgeInsets.only(bottom: 10),
                child: Text(widget.message)),
          ],
        ));
  }
}
