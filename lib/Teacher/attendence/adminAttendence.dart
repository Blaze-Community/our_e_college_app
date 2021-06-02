import 'package:flutter/material.dart';
import 'adminAttendenceItem.dart';


class AdminAttendence extends StatefulWidget {
  @override
  _AdminAttendenceState createState() => _AdminAttendenceState();
}

class _AdminAttendenceState extends State<AdminAttendence> {
  final List items = [
    AdminAttendenceItem(
       name: "Akashdeep",
       attend: 9,
       total: 10,),
    AdminAttendenceItem(
      name: "Ashish",
      attend: 9,
      total: 10,),
    AdminAttendenceItem(
      name: "Harsh",
      attend: 4,
      total: 10,),
    AdminAttendenceItem(
      name: "Vaibhav",
      attend: 0,
      total: 10,),
  ];

  @override
  Widget build(BuildContext context) {
    // items.sort((a, b) => a.submissionDate.compareTo(b.submissionDate));
    return Scaffold(
        appBar: AppBar(
          title: Text("Attendence"),
        ),
        body: Stack(
          children: [
            ListView.builder(
              //physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length+1,
                itemBuilder: (BuildContext ctxt, int i) {
                  if (i == 0) {
                    // return the header
                    return new ListTile(
                      onTap: null,
                      tileColor: Colors.black12,
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                      ),
                      title: Row(
                          children: <Widget>[
                            Expanded(child: Text("Name",style: TextStyle(
                              fontWeight: FontWeight.w900
                            ),)),
                            Expanded(child: Text("Attend",style: TextStyle(
                                fontWeight: FontWeight.w900
                            ),)),
                            Expanded(child: Text("Total",style: TextStyle(
                                fontWeight: FontWeight.w900
                            ),)),
                          ]
                      ),
                    );
                  }
                  i-= 1;
                  return items[i];
                }),
            Padding(
              // bottom: 10,
              padding: EdgeInsets.only(bottom: 10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton.extended(
                  onPressed: () {
                  },
                  label: Text('Upload Attendence'),
                  icon: Icon(Icons.add),
                ),

              )
            )
          ],
        )
        );
  }
}
