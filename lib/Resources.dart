import 'package:flutter/material.dart';
import 'package:our_e_college_app/homeCategoryItem.dart';
import 'package:our_e_college_app/utils/Theme.dart' as AppTheme;

class Resources extends StatelessWidget {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                            icon: Icon(Icons.sort),
                            color: AppTheme.Colors.white,
                            alignment:Alignment.center,
                            onPressed: () {},
                          ),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "All Subjects",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        letterSpacing: 1.9,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                        letterSpacing: 1.9,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Popular ",
                      style: AppTheme.TextTheme.titleRegularBlack),
                  TextSpan(
                      text: "Courses",
                      style: AppTheme.TextTheme.titleRegularOrange),
                ]),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.only(right: 7),
                              child: HomeCategoryItem(
                                primaryColor: AppTheme.Colors.flatRed,
                                primaryIcon: "assets/images/study.svg",
                                primaryTitle: "Chemistry",
                                secondaryColor: AppTheme.Colors.flatOrange,
                                secondaryIcon: "assets/images/flask.svg",
                                secondaryIconHeight: 30,
                              )),
                        ),
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.only(left: 7),
                              child: HomeCategoryItem(
                                primaryColor: AppTheme.Colors.flatPurple,
                                primaryIcon: "assets/images/study.svg",
                                primaryTitle: "Biology",
                                secondaryColor: AppTheme.Colors.flatDeepPurple,
                                secondaryIcon: "assets/images/dna.svg",
                                secondaryIconHeight: 40,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.only(right: 7),
                              child: HomeCategoryItem(
                                primaryColor: AppTheme.Colors.flatDeepPurple,
                                primaryIcon: "assets/images/study.svg",
                                primaryTitle: "Physics",
                                secondaryColor: AppTheme.Colors.flatPurple,
                                secondaryIcon: "assets/images/microscope.svg",
                                secondaryIconHeight: 30,
                              )),
                        ),
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.only(left: 7),
                              child: HomeCategoryItem(
                                primaryColor: AppTheme.Colors.flatOrange,
                                primaryIcon: "assets/images/study.svg",
                                primaryTitle: "Math",
                                secondaryColor: AppTheme.Colors.flatRed,
                                secondaryIcon: "assets/images/design-tool.svg",
                                secondaryIconHeight: 25,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class CourseCard extends StatelessWidget {
  final String title, count, imagePath;

  CourseCard(
    this.title,
    this.count,
    this.imagePath,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 140.0,
            width: 250.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imagePath), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(24),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 15.0,
                      offset: Offset(0.75, 0.95))
                ],
                color: Colors.grey),
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              '$title',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.9,
                  fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
