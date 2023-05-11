import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:our_e_college_app/components/report_bully/reportbully-helper.dart';
import 'package:simple_moment/simple_moment.dart';

import '../../global-helper.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {

  List items;

  @override
  void initState() {
    // TODO: implement initState
    ReportBullyHelper.shared.fetchBullyItemsList();
    super.initState();
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: StreamBuilder(
              stream: ReportBullyStreamControllerHelper.shared.bullyListStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active && GlobalHelper.loading == false) {
                  if (snapshot.hasData) {
                    items = snapshot.data;
                    return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (BuildContext ctxt, int i) {
                          return _buildListItems(
                              items[i]["_id"],
                              items[i]["result"] != null ? items[i]["result"] : "Not Yet Analysed",
                              Moment.parse(items[i]["createdAt"]).format('dd-MM-yyyy'),
                              items[i]["percentage"] != null ? items[i]["percentage"].toString() + "%": "NULL"
                          );
                        });
                  }
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ));
    }

    Widget _buildListItems(
        String id,
        String title,
        String uploadDate,
        String percentage) {
      return Container(
        margin: EdgeInsets.only(bottom: 25),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 15,
                  height: 10,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(5),
                      )),
                ),
                SizedBox(
                  width: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      uploadDate,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey[300]),
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.only(right: 10, left: 30),
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.assignment,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Bully Result: ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              percentage,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ))
          ],
        ),
      );
    }
}
