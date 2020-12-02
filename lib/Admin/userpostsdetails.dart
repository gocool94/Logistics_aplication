import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:async';

class UserPostDetails extends StatefulWidget {
  //LatestPostDetails({Key key}) : super(key: key);
  DocumentSnapshot snapshot;
  UserPostDetails(this.snapshot);

  @override
  _UserPostDetailsState createState() => _UserPostDetailsState();
}

class _UserPostDetailsState extends State<UserPostDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Document for Approval"),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          // new Container(
          //   margin: EdgeInsets.all(10.0),
          //   height: 500.0,
          //   width: MediaQuery.of(context).size.width,
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(15.0),
          //     child: new Image.network(
          //       widget.snapshot.data()["image"],
          //       height: 500.0,
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Column(
              children: <Widget>[
                Image.network(
                  widget.snapshot["image"],
                  height: 400,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 30),
                Text(
                  "Posted By " + widget.snapshot["posted_by"],
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 26,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 25),
                Text(
                  "Posted on " + widget.snapshot["posted_on"],
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 25,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          new SizedBox(
            height: 10.0,
          ),
          new Container(
            color: Colors.white,
            margin: EdgeInsets.all(10.0),
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              children: <Widget>[
                // new Container(
                //   margin: EdgeInsets.all(10.0),
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //children: <Widget>[
                // new CircleAvatar(
                //     child: Text(
                //       widget.snapshot.data()["title"][0],
                //       style: TextStyle(
                //         fontSize: 22.0,
                //       ),
                //     ),
                //     backgroundColor: Colors.blueGrey),
                //new SizedBox(
                //width: 10.0,
                //),
                // Container(
                //   width: MediaQuery.of(context).size.width / 1.3,
                //   child: new Text(
                //     widget.snapshot.data()["title"],
                //     style: TextStyle(
                //       fontSize: 20.0,
                //       color: Colors.black,
                //     ),
                //   ),
                // ),
                //],
                //),
                //),
                new SizedBox(
                  height: 10.0,
                ),
                // new Text(
                //   widget.snapshot.data()["content"],
                //   style: TextStyle(
                //     fontSize: 15.0,
                //     color: Colors.black,
                //   ),
                // ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //First Container
                      // InkWell(
                      //   onTap: () {
                      //     FirebaseFirestore.instance
                      //         .collection("AdminApproval")
                      //         .doc(widget.snapshot.documentID)
                      //         .delete();
                      //     print("Successful");
                      //     Fluttertoast.showToast(
                      //         msg:
                      //             "Deleted Successfully!!! Refresh the page to see the changes.");
                      //   },
                      //   child: Container(
                      //     margin: EdgeInsets.only(
                      //       right: 10.0,
                      //     ),
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(15.0),
                      //       color: Color(0xFFfff6e6),
                      //     ),
                      //     child: Align(
                      //       alignment: Alignment.center,
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Text(
                      //           "Delete",
                      //           style: TextStyle(
                      //             fontSize: 20.0,
                      //             color: Colors.black,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      //Third Container
                      InkWell(
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection("rejecteddata")
                              // ignore: deprecated_member_use
                              .document()
                              // ignore: deprecated_member_use
                              .setData({
                            "image": widget.snapshot.data()['image'],
                            "posted_by": widget.snapshot.data()['posted_by'],
                            "posted_on": widget.snapshot.data()['posted_on']
                          });
                          print("Successful");

                          //Delete
                          FirebaseFirestore.instance
                              .collection("userdata")
                              .doc(widget.snapshot.documentID)
                              .delete();
                          print("Successful");
                          Fluttertoast.showToast(msg: "Rejected. Refresh the page to see the changes.");
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            right: 10.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.blue[100],
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Reject",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //Second Container(Delete Post)
                      InkWell(
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection("data")
                              // ignore: deprecated_member_use
                              .document()
                              // ignore: deprecated_member_use
                              .setData({
                            "image": widget.snapshot.data()['image'],
                            "posted_by": widget.snapshot.data()['posted_by'],
                            "posted_on": widget.snapshot.data()['posted_on']
                          });
                          print("Successful");

                          //Delete
                          FirebaseFirestore.instance
                              .collection("userdata")
                              .doc(widget.snapshot.documentID)
                              .delete();
                          print("Successful");
                          Fluttertoast.showToast(msg: "Approved. Refresh the page to see the changes.");
                          Navigator.pop(context);
                          return;
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            right: 10.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.blue[100],
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Approve",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
