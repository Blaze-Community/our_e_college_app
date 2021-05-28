import 'package:flutter/material.dart';

class Ebooks extends StatefulWidget {
  @override
  _EbooksState createState() => _EbooksState();
}

class _EbooksState extends State<Ebooks>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Ebooks"),
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