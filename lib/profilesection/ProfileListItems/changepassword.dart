// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class ChangePassword extends StatefulWidget {
//   @override
//   _ChangePasswordState createState() => _ChangePasswordState();
// }

// class _ChangePasswordState extends State<ChangePassword> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         elevation: 1,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.orange,
//           ),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//       body: Container(
//         padding: EdgeInsets.only(left: 16, top: 25, right: 16),
//         child: GestureDetector(
//           onTap: () {
//             FocusScope.of(context).unfocus();
//           },
//           child: ListView(
//             children: [
//               Text(
//                 "Password",
//                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
//               ),
//               SizedBox(
//                 height: 35,
//               ),
//               buildTextField("Current Password", "123456"),
//               buildTextField("New Password", "4245212"),
//               buildTextField("Confirm New Password", "4245212"),
//               SizedBox(
//                 height: 35,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   RaisedButton(
//                     onPressed: () {},
//                     color: Colors.green,
//                     padding: EdgeInsets.symmetric(horizontal: 50),
//                     elevation: 2,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     child: Text(
//                       "SAVE",
//                       style: TextStyle(
//                           fontSize: 14,
//                           letterSpacing: 2.2,
//                           color: Colors.white),
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildTextField(String labelText, String placeholder) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 35.0),
//       child: TextField(
//         decoration: InputDecoration(
//             contentPadding: EdgeInsets.only(bottom: 3),
//             labelText: labelText,
//             floatingLabelBehavior: FloatingLabelBehavior.always,
//             hintText: placeholder,
//             hintStyle: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             )),
//       ),
//     );
//   }
// }

//////////////////////////////////////////////////

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
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.deepOrange,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Center(
            child: Padding(
                padding: EdgeInsets.all(40),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.purple[100]),
                      child: TextField(
                        onChanged: (value) {
                          oldPassword = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Current Password",
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.purple[100]),
                      child: TextField(
                        onChanged: (value) {
                          newPassword = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "New Password",
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.purple[100]),
                      child: TextField(
                        onChanged: (value) {
                          reEnterNewPassword = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Re-enter New Password",
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ClipOval(
                      child: Material(
                        color: Colors.deepPurple, 
                        child: InkWell(
                          splashColor: Colors.deepOrange, 
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child:
                                Icon(Icons.done, size: 30, color: Colors.white),
                          ),
                          onTap: () {
                            _changePassword(newPassword);
                          },
                        ),
                      ),
                    )
                  ],
                )))));
  }
}

