import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:our_e_college_app/components/annoucement/announcementlist.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:our_e_college_app/utils/Theme.dart' as AppTheme;
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
    String url = 'https://fetch-announcements.herokuapp.com/faculty-notices';
    print('Start toh hua');
    print('heyyyy');
    final response = await http.get(Uri.parse(url));
    print('byeeee');

    final responseJson = json.decode(response.body);

    for (var ele in responseJson) {
      outerListFacultyNotices.add(ele['title']);
      innerListFacultyNotices.add([ele['title'], '2 May 2001']);
      // print(ele['title'] + ele['link']);
    }
    print(outerListFacultyNotices);
    print(innerListFacultyNotices);
    // return response;
  }
  void studentNotices() async {
    String url = 'https://fetch-announcements.herokuapp.com/student-notices';
    print('Start toh hua');
    print('heyyyy');
    final response = await http.get(Uri.parse(url));
    print('byeeee');

    final responseJson = json.decode(response.body);

    for (var ele in responseJson) {
      outerListFacultyNotices.add(ele['title']);
      innerListFacultyNotices.add([ele['title'], '2 May 2001']);
      // print(ele['title'] + ele['link']);
    }
    print(outerListFacultyNotices);
    print(innerListFacultyNotices);
    // return response;
  }
  void facultyAchievements() async {
    String url = 'https://fetch-announcements.herokuapp.com/faculty-achievements';
    print('Start toh hua');
    print('heyyyy');
    final response = await http.get(Uri.parse(url));
    print('byeeee');

    final responseJson = json.decode(response.body);

    for (var ele in responseJson) {
      outerListFacultyNotices.add(ele['title']);
      innerListFacultyNotices.add([ele['title'], '2 May 2001']);
      // print(ele['title'] + ele['link']);
    }
    print(outerListFacultyNotices);
    print(innerListFacultyNotices);
    // return response;
  }
  void studentAchievements() async {
    String url = 'https://fetch-announcements.herokuapp.com/student-achievements';
    print('Start toh hua');
    print('heyyyy');
    final response = await http.get(Uri.parse(url));
    print('byeeee');

    final responseJson = json.decode(response.body);

    for (var ele in responseJson) {
      outerListFacultyNotices.add(ele['title']);
      innerListFacultyNotices.add([ele['title'], '2 May 2001']);
      // print(ele['title'] + ele['link']);
    }
    print(outerListFacultyNotices);
    print(innerListFacultyNotices);
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
              announcement: ['welcome to our scj=hool', 'gjlshdfkh'],
              // announcement: outerListFacultyNotices,
              color: AppTheme.Colors.flatOrange,
              icon: FontAwesomeIcons.scroll,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AnnouncementList(
                              title: 'Teacher Notices',
                              announcementList: [
                                ['welcome to our scj=hool', '2 May 2001'],
                                ['gjlshdfkh', '4 May 2001']
                              ],
                              // announcementList: innerListFacultyNotices,
                            )));
              },
            ),
            AnnouncementItem(
              title: 'Student Notices',
              icon: FontAwesomeIcons.scroll,
              announcement: ['hgffkga', 'hgfadgfd'],
              color: AppTheme.Colors.flatPurple,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AnnouncementList(
                              title: 'Student Notices',
                              announcementList: [
                                ['hgffkga', '2 May 2001'],
                                ['hgfadgfd', '4 May 2001']
                              ],
                            )));
              },
            ),
            AnnouncementItem(
              title: 'Teacher Achievement',
              icon: FontAwesomeIcons.trophy,
              announcement: ['welcome to our scj=hool', 'gjlshdfkh'],
              color: AppTheme.Colors.flatDeepPurple,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AnnouncementList(
                              title: 'Teacher Achievement',
                              announcementList: [
                                ['welcome to our scj=hool', '2 May 2001'],
                                ['gjlshdfkh', '4 May 2001']
                              ],
                            )));
              },
            ),
            AnnouncementItem(
              title: 'Student Achievements',
              icon: FontAwesomeIcons.trophy,
              announcement: ['hgffkga', 'hgfadgfd'],
              color: AppTheme.Colors.flatRed,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AnnouncementList(
                              title: 'Student Achivement',
                              announcementList: [
                                ['hgffkga', '2 May 2001'],
                                ['hgfadgfd', '4 May 2001']
                              ],
                            )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
