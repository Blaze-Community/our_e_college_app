import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:our_e_college_app/components/classroom/data/comments.dart';
import 'package:our_e_college_app/global.dart' as Global;
import 'package:our_e_college_app/components/classroom/classroom_helper.dart';

class CommentComposer extends StatefulWidget {
  final String message;
  final String date;
  CommentComposer({this.date, this.message});
  @override
  _CommentComposerState createState() => _CommentComposerState();
}

class _CommentComposerState extends State<CommentComposer> {
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
                    onPressed: () {},
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
