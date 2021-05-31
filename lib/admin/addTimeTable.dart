import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddTimeTable extends StatefulWidget {
  @override
  _AddTimeTableState createState() => _AddTimeTableState();
}

class _AddTimeTableState extends State<AddTimeTable> {
  String batch, branch, section;
  List batchItems = ["2018-22", "2019-23", "2020-24", "2021-25"];
  List branchItems = ["CSE", "ECE"];
  List sectionItems = ["Section - A", "Section - B"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        elevation: 0.0,
        title: Text('Add Time Table',
            style: TextStyle(
                fontFamily: 'Montserrat', fontSize: 18.0, color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton(
                hint: Text("Select Batch"),
                icon: Icon(Icons.arrow_drop_down),
                value: batch,
                onChanged: (newValue) {
                  setState(() {
                    batch = newValue;
                  });
                },
                items: batchItems.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
              ),
              DropdownButton(
                hint: Text("Select Branch"),
                icon: Icon(Icons.arrow_drop_down),
                value: branch,
                onChanged: (newValue) {
                  setState(() {
                    branch = newValue;
                  });
                },
                items: branchItems.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
              ),
              DropdownButton(
                hint: Text("Select Section"),
                icon: Icon(Icons.arrow_drop_down),
                value: section,
                onChanged: (newValue) {
                  setState(() {
                    section = newValue;
                  });
                },
                items: sectionItems.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          OutlinedButton(
              onPressed: () {},
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.upload, size: 25),
                    SizedBox(width: 10),
                    Text(
                      "Upload json file",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              )),
          SizedBox(height: 20),
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
                      "Submit",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              )),
        ]),
      ),
    );
  }
}
