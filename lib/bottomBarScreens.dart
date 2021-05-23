import 'package:flutter/material.dart';
import 'package:our_e_college_app/components/attendence.dart';
import 'package:our_e_college_app/main.dart';
import 'package:our_e_college_app/utils/homepage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Attendence(),
    );
  }
}