import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'global.dart' as global;
import 'app.dart';

const users = const {
  'test1@gmail.com': '123',
  'test@gmail.com': '123'
};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    if(data.name == "test1@gmail.com"){
      global.user = "Teacher";
    }else{
      global.user = "Student";
    }
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'Username does not exist';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username does not exist';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      onLogin: _authUser,
      onSignup: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => App(),
        ));
      },
      onRecoverPassword: _recoverPassword,
      hideSignUpButton: true,
    );
  }
}