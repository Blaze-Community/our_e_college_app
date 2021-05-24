import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:our_e_college_app/components/announcementlist.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:our_e_college_app/utils/Theme.dart' as AppTheme;
import 'package:our_e_college_app/utils/announcementItem.dart';

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
        padding: EdgeInsets.only(top: 50.0),
        child: Container(
            height: 600.0,
            padding: EdgeInsets.only(bottom: 25.0),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(left: 18.0, right: 22.0),
              scrollDirection: Axis.vertical,
              children: [
                Row(
                  children: [
                    AnnouncementItem(
                      title: 'Teacher Notices',
                      announcement: ['welcome to our scj=hool', 'gjlshdfkh'],
                      color: AppTheme.Colors.flatOrange,
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    AnnouncementList(
                                      title: 'Teacher Notices',
                                      announcement: [['gfkasfge','23:23']],
                                    )));
                      },
                    ),
                    AnnouncementItem(
                      title: 'Student Notices',
                      announcement: ['hgffkga', 'hgfadgfd'],
                      color: AppTheme.Colors.flatPurple,
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                   AnnouncementList(
                                     title: 'Student Notices',
                                     announcement: [['gfkasfge','23:23']],
                                   )));
                      },
                    )
                  ],
                ),
                Row(
                  children: [
                    AnnouncementItem(
                      title: 'Teacher Achivement',
                      announcement: ['welcome to our scj=hool', 'gjlshdfkh'],
                      color: AppTheme.Colors.flatDeepPurple,
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    AnnouncementList(
                                      title: 'Teacher Achivement',
                                      announcement: [['gfkasfge','23:23']],
                                    )));
                      },
                    ),
                    AnnouncementItem(
                      title: 'Student Achivement',
                      announcement: ['hgffkga', 'hgfadgfd'],
                      color: AppTheme.Colors.flatRed,
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    AnnouncementList(
                                      title: 'Student Achivement',
                                      announcement: [['gfkasfge','23:23']],
                                    )));
                      },
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
