import 'package:flutter/material.dart';

class Transport extends StatefulWidget {
  @override
  _TransportState createState() => _TransportState();
}

class _TransportState extends State<Transport>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Transport"),
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