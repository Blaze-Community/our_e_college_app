import 'package:flutter/material.dart';
import 'adminRenamItem.dart';


class AdminResult extends StatefulWidget {
  @override
  _AdminResultState createState() => _AdminResultState();
}

class _AdminResultState extends State<AdminResult> {
  final List items = [
    AdminResultItem(
       name: "Akashdeep",
       marks: 99,
       total: 100,),
    AdminResultItem(
      name: "Ashish",
      marks: 69,
      total: 100,),
    AdminResultItem(
      name: "Harsh",
      marks: 49,
      total: 100,),
    AdminResultItem(
      name: "Vaibhav",
      marks: 0,
      total: 100,),
  ];

  @override
  Widget build(BuildContext context) {
    // items.sort((a, b) => a.submissionDate.compareTo(b.submissionDate));
    return Scaffold(
        appBar: AppBar(
          title: Text("Result"),
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
                            Expanded(child: Text("Marks",style: TextStyle(
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
                  label: Text('Add Result'),
                  icon: Icon(Icons.add),
                ),

              )
            )
          ],
        )
        );
  }
}
