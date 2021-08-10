import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:our_e_college_app/global-helper.dart';
import 'package:photo_view/photo_view.dart';

class Ecard extends StatefulWidget {
  @override
  _EcardState createState() => _EcardState();
}

class _EcardState extends State<Ecard>{
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
              child: FlipCard(
                direction: FlipDirection.HORIZONTAL, // default
                front: Container(
                  child: FutureBuilder(
                    future: GlobalHelper.shared.fetchCurrentUser(),
                    builder:(context,snapshot){
                      if (snapshot.connectionState == ConnectionState.done) {
                        print(snapshot.data);
                        return Container(
                          child: PhotoView(
                            imageProvider: NetworkImage(snapshot.data["e_card"]),
                            backgroundDecoration: BoxDecoration(color: Colors.white),
                          ),
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ),
                back: Container(
                  child: FutureBuilder(
                    future: GlobalHelper.shared.fetchCurrentUser(),
                    builder:(context,snapshot){
                      if (snapshot.connectionState == ConnectionState.done) {
                        print("E-Card" + snapshot.data["e_card"]);
                        return Container(
                          child: PhotoView(
                            imageProvider: NetworkImage(snapshot.data["e_card"]),
                            backgroundDecoration: BoxDecoration(color: Colors.white),
                          ),
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ),
              )

            ),
          ),

        ));
  }

}