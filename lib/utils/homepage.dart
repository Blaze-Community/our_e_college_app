import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:our_e_college_app/utils/Theme.dart' as AppTheme;
import 'package:our_e_college_app/components/timetable.dart';

import 'homeCategoryItem.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isDrawerOpen ? 30 : 0.0),
          color: Colors.grey[200]),
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor),
      duration: Duration(milliseconds: 250),
      child: Container(
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
                          IconButton(
                              icon: Icon(
                                Icons.sort,
                                color: AppTheme.Colors.white,
                              ),
                              onPressed: () {
                                if (isDrawerOpen == false) {
                                  setState(() {
                                    xOffset = 230;
                                    yOffset = 160;
                                    scaleFactor = 0.6;
                                    isDrawerOpen = true;
                                  });
                                } else {
                                  setState(() {
                                    xOffset = 0;
                                    yOffset = 0;
                                    scaleFactor = 1;
                                    isDrawerOpen = false;
                                  });
                                }
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "All Subjects",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                letterSpacing: 1.9,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Please select a study subject",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color(0xffE1F5FF),
                                fontSize: 18,
                                letterSpacing: 1.9,
                                fontWeight: FontWeight.bold),
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
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: HomeCategoryItem(
                      primaryColor: AppTheme.Colors.flatRed,
                      primaryIcon: Icons.announcement,
                      primaryTitle: "Announcement",
                      secondaryColor: AppTheme.Colors.flatOrange,
                      secondaryIcon: Icons.announcement,
                      secondaryIconHeight: 30,
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
                              primaryIcon: Icons.card_travel,
                              primaryTitle: "Holidays",
                              secondaryColor: AppTheme.Colors.flatOrange,
                              secondaryIcon: Icons.card_travel,
                              secondaryIconHeight: 30,
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
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: HomeCategoryItem(
                      primaryColor: AppTheme.Colors.flatRed,
                      primaryIcon: FontAwesomeIcons.bus,
                      primaryTitle: "Transportation",
                      secondaryColor: AppTheme.Colors.flatOrange,
                      secondaryIcon: FontAwesomeIcons.bus,
                      secondaryIconHeight: 30,
                    )),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, right: 16),
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
                                      secondaryColor:
                                          AppTheme.Colors.flatOrange,
                                      secondaryIcon: Icons.assistant_photo,
                                      secondaryIconHeight: 30,
                                    )),
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.1,
                                  child: Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: HomeCategoryItem(
                                        primaryColor:
                                            AppTheme.Colors.flatPurple,
                                        primaryIcon: FontAwesomeIcons.book,
                                        primaryTitle: "E-Book",
                                        secondaryColor:
                                            AppTheme.Colors.flatDeepPurple,
                                        secondaryIcon: FontAwesomeIcons.book,
                                        secondaryIconHeight: 40,
                                      ))),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.1,
                                child: HomeCategoryItem(
                                  primaryColor: AppTheme.Colors.flatRed,
                                  primaryIcon: FontAwesomeIcons.cameraRetro,
                                  primaryTitle: "Video",
                                  secondaryColor: AppTheme.Colors.flatOrange,
                                  secondaryIcon: FontAwesomeIcons.cameraRetro,
                                  secondaryIconHeight: 30,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, right: 16),
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
                                      primaryIcon: FontAwesomeIcons.female,
                                      primaryTitle: "Parenting Guide",
                                      secondaryColor:
                                          AppTheme.Colors.flatOrange,
                                      secondaryIcon: FontAwesomeIcons.female,
                                      secondaryIconHeight: 30,
                                    )),
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.1,
                                  child: Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: HomeCategoryItem(
                                        primaryColor:
                                            AppTheme.Colors.flatPurple,
                                        primaryIcon: FontAwesomeIcons.medkit,
                                        primaryTitle: "Health Tips",
                                        secondaryColor:
                                            AppTheme.Colors.flatDeepPurple,
                                        secondaryIcon: FontAwesomeIcons.medkit,
                                        secondaryIconHeight: 40,
                                      ))),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.1,
                                child: HomeCategoryItem(
                                  primaryColor: AppTheme.Colors.flatRed,
                                  primaryIcon: FontAwesomeIcons.userMd,
                                  primaryTitle: "Vaccinations",
                                  secondaryColor: AppTheme.Colors.flatOrange,
                                  secondaryIcon: FontAwesomeIcons.userMd,
                                  secondaryIconHeight: 30,
                                ),
                              )
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
                    )),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}