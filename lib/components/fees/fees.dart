import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Fees extends StatefulWidget {
  @override
  _FeesState createState() => _FeesState();
}

class _FeesState extends State<Fees> {
  List lis = [];

  void fees() async {
    String url = 'https://iiitn-web-crawler.herokuapp.com/fees';
    final response = await http.get(Uri.parse(url));

    final responseJson = json.decode(response.body);

    for (var ele in responseJson) {
      if (ele['heading'] != null) {
        lis.add([ele['heading']]);
      } else {
        lis.add([ele['text'], ele['link']]);
      }
    }

    setState(() {
      lis = lis;
      // print(lis);
    });
  }

  void initState() {
    super.initState();
    fees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fees"),
        ),
        body: ListView.builder(
          itemCount: lis.length,
          itemBuilder: (BuildContext context, int index) {
            String text = lis[index][0];
            if (lis[index].length == 1) {
              return Text(text,
                  style: TextStyle(fontSize: 20, color: Colors.black));
            } else {
              String link = lis[index][1];
              return TextButton(
                  onPressed: () async {
                    bool _validURL = Uri.parse(link).isAbsolute;
                    if (_validURL == true) {
                      await launch(link);
                    } else {
                      await launch(
                          "https://iiitn.ac.in//page.php?name=fees&id=42" +
                              link);
                    }
                  },
                  child: Text(text,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600])));
            }
          },
        ));
  }
}
