import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:our_e_college_app/Resources.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'College App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(title: TextStyle(fontFamily: "Nunito"))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 16.0, bottom: 32),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Resources()));
          },
          label: Text('Get Started',
              style: TextStyle(
                  color: Color(0xffE1F5FF),
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          icon: Icon(Icons.arrow_forward_sharp),
          backgroundColor: Colors.blue,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/splash2.jpg"), fit: BoxFit.fill),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "World's Best",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color(0xffE1F5FF),
                    fontSize: 18,
                    letterSpacing: 0.9,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Education  Resources",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    letterSpacing: 1.9,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Anytime, Anywhere, Easy to Learn",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color(0xffE1F5FF),
                    fontSize: 18,
                    letterSpacing: 1.9,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
