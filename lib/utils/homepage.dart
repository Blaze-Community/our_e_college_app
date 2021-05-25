import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:our_e_college_app/components/annoucement.dart';
import 'package:our_e_college_app/components/attendence.dart';
import 'package:our_e_college_app/utils/Theme.dart' as AppTheme;
import 'package:our_e_college_app/components/timetable.dart';
import 'package:our_e_college_app/components/results.dart';
import 'package:our_e_college_app/components/assignment.dart';
import 'package:our_e_college_app/components/buySell.dart';

import 'homeCategoryItem.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        // Box decoration takes a gradient
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.4, 0.7, 0.5, 0.5],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Color(0xfffafdff),
            Color(0xfffafdff),
            Color(0xffE7FFFF),
            Color(0xffE7FFFF),
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 260,
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(45),
                  bottomRight: Radius.circular(45),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage(
                          "assets/1.jpg",
                        ),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "IIIT N",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    letterSpacing: 1.9,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 30.0,
                            ),
                          ]),
                          margin: EdgeInsets.only(
                              top: 16.0, left: 16.0, right: 16.0),
                          height: 62,
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(
                                    right: 4.0, top: 2, bottom: 2, left: 2.0),
                                child: SizedBox(
                                  width: 64.0,
                                  child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      color: Color(0xffeef1f3),
                                      onPressed: () {},
                                      child: Center(
                                        child: Icon(
                                          Icons.search,
                                          size: 32,
                                          color: Colors.black,
                                        ),
                                      )),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Search ',
                              hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w600),
                              contentPadding:
                              EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
          //Body
          Expanded(
            child: ListView(children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(right: 7),
                          child: HomeCategoryItem(
                            primaryColor: AppTheme.Colors.flatRed,
                            primaryIcon: Icons.perm_contact_calendar,
                            primaryTitle: "E-Card",
                            secondaryColor: AppTheme.Colors.flatOrange,
                            secondaryIcon: Icons.perm_contact_calendar,
                            secondaryIconHeight: 30,
                          )),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: HomeCategoryItem(
                          primaryColor: AppTheme.Colors.flatPurple,
                          primaryIcon: Icons.av_timer,
                          primaryTitle: "TimeTable",
                          secondaryColor: AppTheme.Colors.flatDeepPurple,
                          secondaryIcon: Icons.av_timer,
                          secondaryIconHeight: 40,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        TimeTable()));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: HomeCategoryItem(
                    primaryColor: AppTheme.Colors.flatRed,
                    primaryIcon: Icons.announcement,
                    primaryTitle: "Announcement",
                    secondaryColor: AppTheme.Colors.flatOrange,
                    secondaryIcon: Icons.announcement,
                    secondaryIconHeight: 30,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Annoucement()));
                    },
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(right: 7),
                          child: HomeCategoryItem(
                            primaryColor: AppTheme.Colors.flatRed,
                            primaryIcon: Icons.event_available,
                            primaryTitle: "Attendence",
                            secondaryColor: AppTheme.Colors.flatOrange,
                            secondaryIcon: Icons.event_available,
                            secondaryIconHeight: 30,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Attendence()));
                            },
                          )),
                    ),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 7),
                          child: HomeCategoryItem(
                            primaryColor: AppTheme.Colors.flatPurple,
                            primaryIcon: Icons.assessment,
                            primaryTitle: "Results",
                            secondaryColor: AppTheme.Colors.flatDeepPurple,
                            secondaryIcon: Icons.assessment,
                            secondaryIconHeight: 40,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Result()));
                            },
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(right: 7),
                          child: HomeCategoryItem(
                            primaryColor: AppTheme.Colors.flatRed,
                            primaryIcon: Icons.assignment,
                            primaryTitle: "Assignments",
                            secondaryColor: AppTheme.Colors.flatOrange,
                            secondaryIcon: Icons.assignment,
                            secondaryIconHeight: 30,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Assignment()));
                            },
                          )),
                    ),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 7),
                          child: HomeCategoryItem(
                            primaryColor: AppTheme.Colors.flatPurple,
                            primaryIcon: Icons.attach_money,
                            primaryTitle: "Fees",
                            secondaryColor: AppTheme.Colors.flatDeepPurple,
                            secondaryIcon: Icons.attach_money,
                            secondaryIconHeight: 40,
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: HomeCategoryItem(
                    primaryColor: AppTheme.Colors.flatRed,
                    primaryIcon: FontAwesomeIcons.bus,
                    primaryTitle: "Transportation",
                    secondaryColor: AppTheme.Colors.flatOrange,
                    secondaryIcon: FontAwesomeIcons.bus,
                    secondaryIconHeight: 30,
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: SizedBox(
                    height: 105,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 2.1,
                              child: Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: HomeCategoryItem(
                                    primaryColor: AppTheme.Colors.flatRed,
                                    primaryIcon: Icons.assistant_photo,
                                    primaryTitle: "Exams",
                                    secondaryColor: AppTheme.Colors.flatOrange,
                                    secondaryIcon: Icons.assistant_photo,
                                    secondaryIconHeight: 30,
                                  )),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width / 2.1,
                                child: Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: HomeCategoryItem(
                                      primaryColor: AppTheme.Colors.flatPurple,
                                      primaryIcon: FontAwesomeIcons.book,
                                      primaryTitle: "E-Book",
                                      secondaryColor:
                                      AppTheme.Colors.flatDeepPurple,
                                      secondaryIcon: FontAwesomeIcons.book,
                                      secondaryIconHeight: 40,
                                    ))),
                          ],
                        ),
                      ],
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: HomeCategoryItem(
                    primaryColor: AppTheme.Colors.flatRed,
                    primaryIcon: Icons.receipt,
                    primaryTitle: "Offers",
                    secondaryColor: AppTheme.Colors.flatOrange,
                    secondaryIcon: Icons.receipt,
                    secondaryIconHeight: 30,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BuySell()));
                    },
                  )),
            ]),
          ),
        ],
      ),
    );
  }
}