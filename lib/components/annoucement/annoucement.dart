import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:our_e_college_app/components/annoucement/announcementlist.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:our_e_college_app/utils/Theme.dart' as AppTheme;
import 'package:our_e_college_app/components/annoucement/announcementItem.dart';

class Annoucement extends StatefulWidget {
  @override
  _Annoucement createState() => _Annoucement();
}

class _Annoucement extends State<Annoucement> {
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
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          scrollDirection: Axis.vertical,
          children: [
            Row(
              children: [
                AnnouncementItem(
                  title: 'Teacher Notices',
                  announcement: ['welcome to our scj=hool', 'gjlshdfkh'],
                  color: AppTheme.Colors.flatOrange,
                  icon: FontAwesomeIcons.scroll,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => AnnouncementList(
                                  title: 'Teacher Notices',
                                  announcement: [
                                    ['welcome to our scj=hool', '2 May 2001'],
                                    ['gjlshdfkh', '4 May 2001']
                                  ],
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
                                  announcement: [
                                    ['hgffkga', '2 May 2001'],
                                    ['hgfadgfd', '4 May 2001']
                                  ],
                                )));
                  },
                )
              ],
            ),
            Row(
              children: [
                AnnouncementItem(
                  title: 'Teacher Achivement',
                  icon: FontAwesomeIcons.trophy,
                  announcement: ['welcome to our scj=hool', 'gjlshdfkh'],
                  color: AppTheme.Colors.flatDeepPurple,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => AnnouncementList(
                                  title: 'Teacher Achivement',
                                  announcement: [
                                    ['welcome to our scj=hool', '2 May 2001'],
                                    ['gjlshdfkh', '4 May 2001']
                                  ],
                                )));
                  },
                ),
                AnnouncementItem(
                  title: 'Student Achivement',
                  icon: FontAwesomeIcons.trophy,
                  announcement: ['hgffkga', 'hgfadgfd'],
                  color: AppTheme.Colors.flatRed,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => AnnouncementList(
                                  title: 'Student Achivement',
                                  announcement: [
                                    ['hgffkga', '2 May 2001'],
                                    ['hgfadgfd', '4 May 2001']
                                  ],
                                )));
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
