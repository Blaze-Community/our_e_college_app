import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:our_e_college_app/LoginScreen.dart';
import 'package:our_e_college_app/profilesection/ProfileListItems/changepassword.dart';
import 'package:our_e_college_app/profilesection/ProfileListItems/editprofile.dart';
import 'package:our_e_college_app/profilesection/profilelistitem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
  
}

class _ProfileState extends State<Profile> {
  String profileImageUri;
  String profileName;
  Future getProfileImageFromDatabase() async {
    var uid = FirebaseAuth.instance.currentUser.uid;
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        return await documentSnapshot.data();
      } else {
        print('Document does not exist on the user database');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              FutureBuilder(
                future: getProfileImageFromDatabase(),
                builder:(context,snapshot){
                  if (snapshot.connectionState == ConnectionState.done) {
                    print(snapshot.data);
                    if(snapshot.hasData){
                      profileImageUri = snapshot.data["profilePhotoUri"];
                      profileName = snapshot.data["profileName"];
                      return  Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.only(top: 30),
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.white,
                                  foregroundImage: (snapshot.data["profilePhotoUri"].length>0)?
                                            NetworkImage(snapshot.data["profilePhotoUri"]):
                                            AssetImage("assets/splash.jpg"),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(snapshot.data["profileName"],
                          ),
                          SizedBox(height: 5),
                          Text(snapshot.data["email"],
                          ),
                        ],
                      );
                    }
                  }
                  return Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        margin: EdgeInsets.only(top: 30),
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                                child: CircularProgressIndicator(
                                )
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'StudentName',
                      ),
                      SizedBox(height: 5),
                      Text(
                        'E-Mail',
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 20),
              Expanded(
                  child: Column(children: [
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: ListView(
                  children: [
                    ProfileListItems(
                      icon: Icons.edit,
                      text: 'Edit Profile',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    EditProfile(profileImageUri:profileImageUri,profileName: profileName,)));
                      },
                    ),
                    ProfileListItems(
                      icon: Icons.password,
                      text: 'Change Password',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ChangePassword()));
                      },
                    ),
                    ProfileListItems(
                      icon: Icons.book,
                      text: 'Backlogs',
                      onPressed: () {},
                    ),
                    ProfileListItems(
                      icon: Icons.calendar_today,
                      text: 'Acadmic Calendar',
                      onPressed: () {},
                    ),
                    ProfileListItems(
                      icon: Icons.notifications,
                      text: 'Notification',
                      onPressed: () {},
                    ),
                    ProfileListItems(
                      icon: Icons.security,
                      text: 'About Us',
                      onPressed: () {},
                    ),
                    ProfileListItems(
                        icon: Icons.logout,
                        text: 'Logout',
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          final SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.remove('email');
                          Navigator.pushReplacement(
                              ContextKeeper.buildContext,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginScreen()));
                        }),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ))
              ])),
            ],
          ),
        ));
  }
}
