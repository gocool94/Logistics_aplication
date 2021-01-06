import 'dart:io';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class createpost extends StatefulWidget {
  @override
  _createpostState createState() => _createpostState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _createpostState extends State<createpost> {
  AppState state;
  File imageFile;

  TextEditingController _postdescriptionController;

  String _categoryVal;
  String _postType;
  String imageurl;
  File image;
  String filename;
  bool _isloading = false;
  double _progress;

  final User user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    state = AppState.free;

    _postdescriptionController = TextEditingController(text: "");
  }

  Future<String> uploadImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(filename);

    UploadTask uploadTask = ref.putFile(image);

    Fluttertoast.showToast(msg: "Wait for image to upload");

    uploadTask.events.listen((event) {
      setState(() {
        _isloading = true;
        _progress = event.snapshot.bytesTransferred.toDouble() /
            event.snapshot.totalByteCount.toDouble();
        print(_progress);
      });
    });

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {
      var x = 2;
    });

    final String url = (await taskSnapshot.ref.getDownloadURL());
    print('URL Is $url');

    imageurl = url;
    Fluttertoast.showToast(
        msg: "Image Uploaded Successfully. Now you can Submit!!!");
    return url;
  }

  Widget uploadArea() {
    return Column(
      children: <Widget>[
        Image.file(image, width: double.infinity),
        //Padding(padding: EdgeInsets.all(8)),
        FlatButton.icon(
          onPressed: () {
            uploadImage();
            print(filename);
          },
          icon: Icon(Icons.cloud_upload),
          label: Text("Upload"),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }

  Widget _contenttextfield() {
    return TextField(
      controller: _postdescriptionController,
      decoration: InputDecoration(
          labelText: "Description",
          hintText: "Type description here....",
          border: OutlineInputBorder()),
      maxLines: 8,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text(
            "Upload Document",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue[500],
          //iconTheme: new IconThemeData(color: Colors.white),
        ),
        body: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            SizedBox(height: 10.0),
            // _contenttextfield(),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  image == null ? Text("No image selected") : uploadArea(),
                  Container(
                    child: Row(
                      children: [
                        FlatButton.icon(
                            onPressed: () => _pickImageCamera(),
                            padding: EdgeInsets.only(right: 100),
                            icon: Icon(Icons.camera),
                            label: Text('Camera')),
                        FlatButton.icon(
                            onPressed: () => _pickImageGallery(),
                            icon: Icon(Icons.photo_library),
                            label: Text('Gallery')),
                      ],
                    ),
                  )
                ],
              ),
            ),
            _contenttextfield(),
            SizedBox(height: 15.0),
            Container(
              height: 50,
              child: Center(
                child: RaisedButton(
                  onPressed: () async {
                    if (image == null) {
                      Fluttertoast.showToast(msg: " Please select Image!!");
                      return;
                    }
                    if (imageurl == null) {
                      Fluttertoast.showToast(msg: " Please Upload Image!!");
                      return;
                    }
                    if (_postdescriptionController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: " Please enter description!!");
                      return;
                    } else {
                      // ignore: deprecated_member_use
                      Firestore.instance
                          .collection("userdata")
                          // ignore: deprecated_member_use
                          .document()
                          // ignore: deprecated_member_use
                          .setData({
                        "image": imageurl,
                        "description": _postdescriptionController.text,
                        "posted_by": user.email,
                        "posted_on": DateTime.now().toString()
                      });

                      Fluttertoast.showToast(msg: " Posted Successfully!!");
                      Navigator.pop(context);
                      return;
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: const EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue[500],
                          Colors.blue[200],
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(80.0)),
                    ),
                    child: Container(
                      constraints: const BoxConstraints(
                          minWidth: 88.0,
                          minHeight: 36.0), // min sizes for Material buttons
                      alignment: Alignment.center,
                      child: Text("SUBMIT",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Future<Null> _pickImageGallery() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.blue[500],
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      setState(() {
        image = croppedFile;
        filename = basename(image.path);
        state = AppState.cropped;
      });
    }
  }

  Future<Null> _pickImageCamera() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.blue[500],
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      setState(() {
        image = croppedFile;
        filename = basename(image.path);
        state = AppState.cropped;
      });
    }
  }
}
