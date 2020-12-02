import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Int_PostDetails extends StatefulWidget {
  //Int_PostDetails({Key key}) : super(key: key);

  DocumentSnapshot snapshot;

  Int_PostDetails(this.snapshot);

  @override
  _Int_PostDetailsState createState() => _Int_PostDetailsState();
}

class _Int_PostDetailsState extends State<Int_PostDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: new Text(
          "Document",
          style: TextStyle(color: Colors.grey[800]),
        ),
      ),
      body: Center(
          child: Padding(
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
              "Posted on " + widget.snapshot['posted_on'],
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 25,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      )),
    );
  }
}
