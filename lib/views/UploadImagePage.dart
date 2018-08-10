import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

class UploadImagePage extends StatefulWidget {
  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {

  File _image;

  Future getImage() async {
//    var image = await ImagePicker.pickImage(source: ImageSource.camera);
//    setState(() {
//      _image = image;
//    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("上传头像"),

      ),

    );
  }
}
