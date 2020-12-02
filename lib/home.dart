import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
//import 'package:fl_fire_auth/Admin/createpost.dart';

import 'Authentication/auth_helper.dart';
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'View/InternationalNews/officialdata.dart';
import 'createpost.dart';
import 'dart:async';

class Home extends StatefulWidget {
  //Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: cancel_subscriptions
  StreamSubscription<QuerySnapshot> subscription;

  List<DocumentSnapshot> snapshot;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('LatestPost');
  // ignore: deprecated_member_use
  //final FirebaseUser user = FirebaseAuth.instance.currentUser;
  final User user = FirebaseAuth.instance.currentUser;

  void initState() {
    subscription = collectionReference.snapshots().listen((datasnap) {
      setState(() {
        // ignore: deprecated_member_use
        snapshot = datasnap.documents;
      });
    });
    super.initState();
    //print("User Loggedin " + user.email);
  }

  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      key: drawerKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Logistics",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlueAccent,
        brightness: Brightness.light,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          onPressed: () {
            drawerKey.currentState.openDrawer();
          },
          icon: Icon(EvaIcons.menu2Outline),
        ),
      ),
      drawerEdgeDragWidth: 0,
      // drawerDragStartBehavior: DragStartBehavior.start,
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(16),
              ),
              accountEmail: new Text(
                user.email,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              accountName: Text(
                "Welcome!!",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              currentAccountPicture: ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child: Image(
                  image: AssetImage("images/avatar.png"),
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text("Home"),
              leading: Icon(EvaIcons.homeOutline),
              onTap: () {
                Navigator.of(context)
                    .push(new MaterialPageRoute(builder: (context) => Home()));
              },
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text("Delivery 1"),
              leading: Icon(Icons.delivery_dining),
              onTap: () {},
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text("Delivery 2"),
              leading: Icon(Icons.delivery_dining),
              onTap: () {},
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text("Delivery 3"),
              leading: Icon(Icons.delivery_dining),
              onTap: () {},
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text("Delivery 4"),
              leading: Icon(Icons.delivery_dining),
              onTap: () {},
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text("Logout"),
              leading: Icon(EvaIcons.logOutOutline),
             onTap: () {
                Navigator.of(context).pop();
                AuthHelper.logOut();
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: new ListView(
        children: <Widget>[
          new SizedBox(
            height: 100.0,
          ),
          //Third Container
          Container(
            margin: EdgeInsets.all(10.0),
            height: 300.0,
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 155.0,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[400],
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            InternationalNews()));
                              },
                              child: Text(
                                "Official Data",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      new SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 155.0,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[400],
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              child: Text(
                                "About",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                new SizedBox(
                  height: 25.0,
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 95.0,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[400],
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (context) => createpost()));
                              },
                              child: Text(
                                "Upload Document",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      //Sign Out
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
