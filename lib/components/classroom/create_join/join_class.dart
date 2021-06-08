import 'package:flutter/material.dart';

class joinclass extends StatefulWidget {
  @override
  _joinclass createState() => _joinclass();
}
class _joinclass extends State<joinclass> {
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
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Key",
                ),
              ),
            ),
            /*TextField(
              decoration: InputDecoration(
                hintText: "Enter the KEY",
                hintStyle: TextStyle(
                  color: Colors.purple,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),*/
            SizedBox(height:45.0),
            ElevatedButton(
              onPressed: () {},
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

