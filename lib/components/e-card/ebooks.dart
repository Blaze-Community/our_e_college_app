import 'package:flutter/material.dart';

class Ecard extends StatefulWidget {
  @override
  _EcardState createState() => _EcardState();
}

class _EcardState extends State<Ecard>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("E-Card"),
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