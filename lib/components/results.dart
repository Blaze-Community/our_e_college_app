import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subjects'),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          CurvedListItem(
            title: 'English',
            color: Colors.red,
            nextColor: Colors.green,
          ),
          CurvedListItem(
            title: 'Hindi',
            color: Colors.green,
            nextColor: Colors.black,
          ),
          CurvedListItem(
            title: 'Maths',
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

class CurvedListItem extends StatelessWidget {
  final String title;
  final String people;
  final IconData icon;
  final Color color;
  final Color nextColor;

  const CurvedListItem({
    this.title,
    this.icon,
    this.people,
    this.color,
    this.nextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: nextColor,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(80.0),
          ),
        ),
        padding: const EdgeInsets.only(
          left: 32,
          top: 80.0,
          bottom: 50,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 2,
              ),
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              Row(),
            ]),
      ),
    );
  }
}
