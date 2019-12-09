import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'dart:io';
import 'dart:core';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  File _image;
  Position _position;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _position = position;
    });
  }

  Future addData() async {
    final FirebaseApp app = await FirebaseApp.configure(
      name: 'TCCFLUTTER',
      options: const FirebaseOptions(
        googleAppID: 'tccflutter-b11d5',
        gcmSenderID: '1:473033131343:android:0e65766316277b507ab13a',
        apiKey: 'AIzaSyC4EVwHjAGT9AUTAsiNnm5ruRT9Rj1nKa4',
        projectID: 'tccflutter-b11d5',
      ),
    );
    final Firestore firestore = Firestore(app: app);

    await firestore.collection("formData").add(<String, dynamic>{
      "img": _image.toString(),
      "coordinates": _position.toString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('TCC FLUTTER'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () {
                  getImage();
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              _image == null ? Container() : Image.file(_image),
              SizedBox(
                height: 10.0,
              ),
              IconButton(
                icon: Icon(Icons.location_on),
                onPressed: () {
                  getLocation();
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              _position == null ? Container() : Text('Localização: $_position'),
              SizedBox(
                height: 30.0,
              ),
              FlatButton(
                child: Text("Salvar"),
                onPressed: () {
                  addData();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
