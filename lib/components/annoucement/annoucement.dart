import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:our_e_college_app/components/annoucement/announcementlist.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:our_e_college_app/homepage/Theme.dart' as AppTheme;
import 'package:our_e_college_app/components/annoucement/announcementItem.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class Annoucement extends StatefulWidget {
  @override
  _Annoucement createState() => _Annoucement();
}

class _Annoucement extends State<Annoucement> {
  List outerListFacultyNotices = [];
  List innerListFacultyNotices = [];

  List outerListStudentNotices = [];
  List innerListStudentNotices = [];

  List outerListFacultyAchievements = [];
  List innerListFacultyAchievements = [];

  List outerListStudentAchievements = [];
  List innerListStudentAchievements = [];
  

  void facultyNotices() async {
    String url = 'https://iiitn-web-crawler-production.up.railway.app/faculty-notices';
    final response = await http.get(Uri.parse(url));

    final responseJson = json.decode(response.body);

    for (var ele in responseJson) {
      outerListFacultyNotices.add(ele['title']);
      innerListFacultyNotices.add({"title":ele['title'],"link":ele['link']});
      // print(ele['title'] + ele['link']);
    }
    setState(() {
      outerListFacultyNotices = outerListFacultyNotices;
      innerListFacultyNotices =innerListFacultyNotices;
    });
    print(outerListFacultyNotices,);
    print(innerListFacultyNotices,);
    // return response;
  }
  void studentNotices() async {
    String url = 'https://iiitn-web-crawler-production.up.railway.app/student-notices';
    final response = await http.get(Uri.parse(url));
    print(response.body);
    final responseJson = json.decode(response.body);

    for (var ele in responseJson) {
      outerListStudentNotices.add(ele['title']);
      innerListStudentNotices.add({"title":ele['title'],"link":ele['link']});
      // print(ele['title'] + ele['link']);
    }
    setState(() {
      outerListStudentNotices = outerListStudentNotices;
      innerListStudentNotices =innerListStudentNotices;
    });
    // return response;
  }
  void facultyAchievements() async {
    String url = 'https://iiitn-web-crawler-production.up.railway.app/faculty-achievements';
    final response = await http.get(Uri.parse(url));

    final responseJson = json.decode(response.body);

    for (var ele in responseJson) {
      outerListFacultyAchievements.add(ele['title']);
      innerListFacultyAchievements.add({"title":ele['title'],"link":ele['link']});
      // print(ele['title'] + ele['link']);
    }
    setState(() {
      outerListFacultyAchievements = outerListFacultyAchievements;
      innerListFacultyAchievements =innerListFacultyAchievements;
    });
    // return response;
  }
  void studentAchievements() async {
    String url = 'https://iiitn-web-crawler-production.up.railway.app/student-achievements';
    final response = await http.get(Uri.parse(url));

    final responseJson = json.decode(response.body);

    for (var ele in responseJson) {
      outerListStudentAchievements.add(ele['title']);
      innerListStudentAchievements.add({"title":ele['title'],"link":ele['link']});
      // print(ele['title'] + ele['link']);
    }
    setState(() {
      outerListStudentAchievements = outerListStudentAchievements;
      innerListStudentAchievements =innerListStudentAchievements;
    });
    // return response;
  }

  void initState() {
    super.initState();
    facultyNotices();
    studentNotices();
    facultyAchievements();
    studentAchievements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcements & Notices'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(left: 25.0, right: 25.0),
          scrollDirection: Axis.vertical,
          children: [
            AnnouncementItem(
              title: 'Teacher Notices',
              announcement: outerListFacultyNotices,
              // announcement: outerListFacultyNotices,
              color: AppTheme.Colors.flatOrange,
              icon: FontAwesomeIcons.scroll,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AnnouncementList(
                              title: 'Teacher Notices',
                              announcementList:innerListFacultyNotices,
                              // announcementList: innerListFacultyNotices,
                            )));
              },
            ),
            AnnouncementItem(
              title: 'Student Notices',
              icon: FontAwesomeIcons.scroll,
              announcement: outerListStudentNotices,
              color: AppTheme.Colors.flatPurple,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AnnouncementList(
                              title: 'Student Notices',
                              announcementList:innerListStudentNotices,
                            )));
              },
            ),
            AnnouncementItem(
              title: 'Teacher Achievement',
              icon: FontAwesomeIcons.trophy,
              announcement: outerListFacultyAchievements,
              color: AppTheme.Colors.flatDeepPurple,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AnnouncementList(
                              title: 'Teacher Achievement',
                              announcementList:innerListFacultyAchievements,
                            )));
              },
            ),
            AnnouncementItem(
              title: 'Student Achievements',
              icon: FontAwesomeIcons.trophy,
              announcement: outerListStudentAchievements,
              color: AppTheme.Colors.flatRed,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AnnouncementList(
                              title: 'Student Achivement',
                              announcementList:innerListStudentAchievements,
                            )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
