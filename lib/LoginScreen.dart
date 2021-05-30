import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global.dart' as global;
import 'app.dart';

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    if (data.name == "teacher@gmail.com") {
      global.user = "Teacher";
    } else {
      global.user = "Student";
    }

    return Future.delayed(loginTime).then((_) async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: data.name, password: data.password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          return 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          return 'Wrong password provided for that user.';
        }
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      onLogin: _authUser,
      onSubmitAnimationCompleted: () async {
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('email', global.user);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => App(),
        ));
      },
      hideSignUpButton: true,
    );
  }
}
