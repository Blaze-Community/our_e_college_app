import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../classroom_helper.dart';

class joinclass extends StatefulWidget {
  @override
  _joinclass createState() => _joinclass();
}
class _joinclass extends State<joinclass> {
  final EnrolKey = TextEditingController();

  joinClass(enrolkey,studentId) async {
    var url = Uri.parse('http://localhost:5000/api/joinClass');
    Map body = {
      "enrolKey":enrolkey,
      "studentId":studentId
    };
    await http.post(url,body:json.encode(body),headers:{'content-type':'application/json'}).then((response){
      Navigator.pop(context);
      ClassRoomHelper.shared.fetchClassRoomlist("60d01593c1f3a30047498cac");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join Class"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0),
          child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.deepPurple)),
              child: TextField(
                controller: EnrolKey,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Key",
                ),
              ),
            ),
            SizedBox(height:45.0),
            ElevatedButton(
              onPressed: () {
                print(EnrolKey.text);
                //joinClass(EnrolKey.text,"60d01516c1f3a30047498ca8");
              },
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.publish, size: 25),
                    SizedBox(width: 10),
                    Text(
                      "Join",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),),
          ],
          ),
        ),
      ),
    );
  }
}

