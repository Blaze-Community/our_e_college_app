import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ecard extends StatefulWidget {
  @override
  _EcardState createState() => _EcardState();
}

class _EcardState extends State<Ecard>{
  Future getImage() async {
    User user = FirebaseAuth.instance.currentUser;
    var uid = user.uid;
    return await FirebaseFirestore.instance
        .collection('Students')
        .doc(uid)
        .get();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("E-Card"),
        ),
        body:  Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: FutureBuilder(
                future: getImage(),
                builder:(context,snapshot){
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Image.network(snapshot.data["e_card"],
                      fit: BoxFit.cover,);
                    }
                    return CircularProgressIndicator();
                },
              ),
            ),
          ),

        ));
  }

}