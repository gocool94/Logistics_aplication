import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Start.dart';
import 'package:flutter/cupertino.dart';
import 'Admin/AdminHome.dart';
import 'Authentication/auth_helper.dart';
import 'home.dart';
import 'Authentication/signup.dart';
import 'package:flutter/material.dart';
import 'Authentication/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Logistics',
      theme: ThemeData(
        // primarySwatch: Colors.orange,
        primaryColor: Colors.blue,
        fontFamily: "poppins",
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            UserHelper.saveUser(snapshot.data);
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(snapshot.data.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final userDoc = snapshot.data;
                  final user = userDoc.data();
                  if (user['role'] == '1') {
                    return AdminHome();
                  } else {
                    print("Super admin");
                    return Home();
                  } //else if (user['role'] == '3') {
                  //   return createlatestpost();
                  // } else if (user['role'] == '4') {
                  //   return createinternationalpost();
                  // } else if (user['role'] == '5') {
                  //   return createlocalpost();
                  // } else if (user['role'] == '6') {
                  //   return createpoliticspost();
                  // } else if (user['role'] == '7') {
                  //   return createsportspost();
                  // } else {
                  //   return Home();
                  // }
                } else {
                  return Material(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
          }
          return Start();
        });
  }
}
