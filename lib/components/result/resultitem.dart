import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ResultItem extends StatefulWidget {
  String subject;
  // String submissionTime;
  String uploadDate;
  int marks;

  ResultItem(
      {this.subject,
        // this.submissionTime,
        this.uploadDate,
        this.marks});

  @override
  _ResultItemState createState() => _ResultItemState();
}

class _ResultItemState extends State<ResultItem> {
  @override
  Widget build(BuildContext context) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.uploadDate,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey[300]),
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.only(right: 10, left: 30),
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.subject,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /*Icon(
                            Icons.assignment,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),*/
                          Text(
                            "Marks: ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            widget.marks.toString() + "/100",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.download,
                            size: 12),
                        SizedBox(width: 10),
                        Text(
                          "MARKSHEET",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
