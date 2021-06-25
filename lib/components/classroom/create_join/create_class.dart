import 'dart:convert';
import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:our_e_college_app/components/classroom/classroom_helper.dart';

class createclass extends StatefulWidget {
  @override
  _createclass createState() => _createclass();
}
class _createclass extends State<createclass> {
  final Subject = TextEditingController();
  final Batch = TextEditingController();
  final Section = TextEditingController();
  final Branch = TextEditingController();

  createClass() async {
    setState(() {
      ClassRoomHelper.loading = true;
    });
    var url = Uri.parse('http://localhost:5000/api/createClass');
    Map body =  {
      "clas": {
        "branch":Branch.text,
        "section": Section.text,
        "subject": Subject.text,
        "batch": Batch.text,
        "createdBy": "60d01593c1f3a30047498cac"
      }
    };
    await http.post(url,body:json.encode(body),headers:{'content-type':'application/json'}).then((response){
      if(response.statusCode == 200) {
        Navigator.pop(context);
        ClassRoomHelper.shared.fetchClassRoomlist("60d01593c1f3a30047498cac");
      }
      else {
        print(json.encode(response.body));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Class"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.deepPurple)),
                child: TextField(
                  controller: Subject,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Subject",
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Container(
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.deepPurple)),
                child: TextField(
                  controller: Batch,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Batch",
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Container(
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.deepPurple)),
                child: TextField(
                  controller: Section,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Section",
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Container(
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.deepPurple)),
                child: TextField(
                  controller: Branch,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Branch",
                  ),
                ),
              ),
              SizedBox(height:45.0),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      ClassRoomHelper.loading = true;
                    });
                    createClass();
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
                          "Create",
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

