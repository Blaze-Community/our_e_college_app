import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';
import '/global.dart' as global;

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String oldPassword;
  String newPassword;
  String reEnterNewPassword;

  void _changePassword(String password) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User currentUser = firebaseAuth.currentUser;
    if (oldPassword != global.password) {
      Toast.show("Old Password you entered is incorrect!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else if (newPassword != reEnterNewPassword) {
      Toast.show("Passwords do not match!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      currentUser.updatePassword(password).then((value) {
        global.password = password;
        Toast.show("Password changed successfully.", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

        Navigator.of(context).pop();
      }).catchError((err) {
        Toast.show("Error!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        print(err.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.orange,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    Text(
                      "Password",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 35.0),
                      child: TextField(
                        onChanged: (value) {
                          oldPassword = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 3),
                            labelText: "Current Password",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 35.0),
                      child: TextField(
                        onChanged: (value) {
                          newPassword = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 3),
                            labelText: "New Password",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 35.0),
                      child: TextField(
                        onChanged: (value) {
                          reEnterNewPassword = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 3),
                            labelText: "Re-enter New Password",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 35,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      ElevatedButton(
                        onPressed: () {
                          _changePassword(newPassword);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 5)),
                          elevation: MaterialStateProperty.all<double>(2),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        child: Text(
                          "SAVE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white),
                        ),
                      ),
                    ])
                  ],
                ))));
  }
}
