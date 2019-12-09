import 'dart:async';

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
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _position = position;
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
               _position == null ? Container() : Text('Location: $_position'),
            ],
          ),
        ),
      ),
    );
  }
}
