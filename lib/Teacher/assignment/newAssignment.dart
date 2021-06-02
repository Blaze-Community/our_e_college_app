import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class NewAssignment extends StatefulWidget {
  @override
  _NewAssignmentState createState() => _NewAssignmentState();
}

class _NewAssignmentState extends State<NewAssignment> {
  String _chosenValue;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Assignment"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 45.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
                child: Column(
              children: [
                Text('Details',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16.0,
                        color: Colors.grey)),
                SizedBox(height: 5),
                Container(height: 1.0, color: Colors.deepOrange, width: 50.0),
                SizedBox(height: 20),
                Container(
                    padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.deepPurple)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                              isExpanded: true,
                              value: _chosenValue,
                              style: TextStyle(color: Colors.black),
                              items: <String>[
                                'DSA',
                                'DPPL',
                                'OS',
                                'DMGT',
                                'SE',
                                'ITW 2'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              hint: Text(
                                "Please choose a Course",
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                    ),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  _chosenValue = value;
                                });
                              },
                            ),
                    )
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.deepPurple)),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Title",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.deepPurple)),
                  child: DateTimeFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black45),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.event_note),
                      labelText: 'Submission Date',
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (e) =>
                        (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                    onDateSelected: (DateTime value) {
                      print(value);
                    },
                  ),
                ),
                SizedBox(height: 20),
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
                            "Upload PDF",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(height: 40),
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
                SizedBox(height: 30)
              ],
            )),
          ),
        ),
      ),
    );
  }
}
