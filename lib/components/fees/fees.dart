import 'package:flutter/material.dart';

class Fees extends StatefulWidget {
  @override
  _FeesState createState() => _FeesState();
}

class _FeesState extends State<Fees>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Fees"),
        ),
      body:  Center(
        child: ElevatedButton(

        onPressed: () {

          Navigator.pop(context);
          },
          child: Text('Coming Soon!!'),
    ),

      ));
  }

}