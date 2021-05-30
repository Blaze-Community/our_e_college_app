import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'bottombar/bottomBarScreens.dart';
import 'bottombar/bottomBarTabItem.dart';
import 'bottombar/bottomNavigation.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  // this is static property so other widget throughout the app
  // can access it simply by AppState.currentTab
  static int currentTab = 0;

  // list tabs here
  final List<TabItem> tabs = [
    TabItem(
      icon: Icons.home,
      page: HomeScreen(),
    ),
    TabItem(
      icon: Icons.person_rounded,
      page: ProfileScreen(),
    ),
  ];
  final List<Student> students = [
    Student(
      uid:"8YiaPL1FJQhKPZKmsb2LOMg4lhA3",
      email: "bt19cse005@gmail.com",
      e_card: "https://firebasestorage.googleapis.com/v0/b/our-e-college-app-909e3.appspot.com/o/e-card%2Ftersa.PNG?alt=media&token=a75d848e-2a61-4ce1-ab0e-dc93567f61be"
    ),
    Student(
        uid:"n2NUIinc9BYN1yPmiQVaK0jU9s43",
        email: "bt19cse006@gmail.com",
        e_card: "https://firebasestorage.googleapis.com/v0/b/our-e-college-app-909e3.appspot.com/o/e-card%2Fphla.PNG?alt=media&token=84b86b69-0232-4c3b-ae83-a6086d5e04d0"),
    Student(
        uid:"acgTOv8RQBTHeRz1V62ixqHPVWm1",
        email: "bt19cse008@gmail.com",
        e_card: "https://firebasestorage.googleapis.com/v0/b/our-e-college-app-909e3.appspot.com/o/e-card%2Flogin.PNG?alt=media&token=3f1e3e0e-494f-4328-b6aa-bd7ce2860002"
    ),
    Student(
        uid:"VvzJy3RJyBeUk4bxgnj9zsrC3vK2",
        email: "bt19cse010@gmail.com",
        e_card: "https://firebasestorage.googleapis.com/v0/b/our-e-college-app-909e3.appspot.com/o/e-card%2Fdusra.PNG?alt=media&token=caef29a3-22e0-4431-9aec-d0c21801e453"
    ),
    Student(
        uid:"2rdhkdsCTDRUQinE3nXzLAn7Sxh2",
        email: "bt19cse023@gmail.com",
        e_card: "https://firebasestorage.googleapis.com/v0/b/our-e-college-app-909e3.appspot.com/o/e-card%2Fchota.PNG?alt=media&token=5a3e4252-25e3-4461-99b5-f205b30e1983"
    )
  ];

  @override
  void initState() {
    super.initState();
    for(var i =0;i<students.length;i++){
      saveStudentToDatabase(students[i].uid, students[i].email, students[i].e_card);
    }
    ContextKeeper().init(context);
    currentTab = 0;
  }
  AppState() {
    // indexing is necessary for proper funcationality
    // of determining which tab is active
    tabs.asMap().forEach((index, details) {
      details.setIndex(index);
    });
  }
  Future<void> saveStudentToDatabase(String uid,String email,String uri,) async {
    CollectionReference studentCollection = FirebaseFirestore.instance.collection('Students');
    await studentCollection.doc(uid).set({
      "uid":uid,
      "email":email,
      "e_card":uri})
        .then((value) => print("Student Added"))
        .catchError((error) => print("Failed to add student: $error"));;
  }
  // sets current tab index
  // and update state
  void _selectTab(int index) {
    if (index == currentTab) {
      // pop to first route
      // if the user taps on the active tab
      tabs[index].key.currentState.popUntil((route) => route.isFirst);
    } else {
      // update the state
      // in order to repaint
      setState(() => currentTab = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    // WillPopScope handle android back btn
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await tabs[currentTab].key.currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (currentTab != 0) {
            // select 'main' tab
            _selectTab(0);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      // this is the base scaffold
      // don't put appbar in here otherwise you might end up
      // with multiple appbars on one screen
      // eventually breaking the app
      child: Scaffold(
        // indexed stack shows only one child
        body: IndexedStack(
          index: currentTab,
          children: tabs.map((e) => e.page).toList(),
        ),
        // Bottom navigation
        bottomNavigationBar: BottomNavigation(
          onSelectTab: _selectTab,
          tabs: tabs,
        ),
      ),
    );
  }
}
class ContextKeeper {
  static BuildContext buildContext;

  void init(BuildContext context) {
    buildContext = context;
  }
}
class Student{
    String uid;
    String email;
    String e_card;

    Student({
        this.uid,
        this.email,
        this.e_card});
}