import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:idota/utils/HttpUtils.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_compress/image_compress.dart';
import 'package:path_provider/path_provider.dart';

class UploadImagePage extends StatefulWidget {
  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  File _image;

  bool showLoadingDialog = false;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future uploadImg() async {
    if (_image == null) {
      Fluttertoast.showToast(
          msg: "没有图片",
          toastLength: Toast.LENGTH_SHORT,
          bgcolor: "#e74c3c",
          textcolor: '#ffffff');
      return;
    }

    showLoadingDialog = true;
    setState(() {});
    var file = await _getLocalFile();
    await ImageCompress.compressImageToFile(_image.path, file);
//    String file = "/idota/";
//    print("encode" + _image.path);
//    String newfileName = await ImageJpeg.encodeJpeg(_image.path, file, 70, 500, 500);

//    print(newfileName);
    var res = await HttpUtils.getInstance().post("/user/uploadImg",
        data: {'img': UploadFileInfo(file, "upload.jpg")});
    if(!mounted){
      return;
    }
    if (res['code'] == 0) {
      Fluttertoast.showToast(
          msg: "上传成功",
          toastLength: Toast.LENGTH_SHORT,
          bgcolor: "#e74c3c",
          textcolor: '#ffffff');
      Navigator.of(context).pop();
    } else {
      showLoadingDialog = false;
      setState(() {});
    }
  }

  Future<File> _getLocalFile() async {
    // 获取本地文档目录
    String dir = (await getApplicationDocumentsDirectory()).path;
    // 返回本地文件目录
    return new File('$dir/counter.jpg');
  }

  @override
  void initState() {
    super.initState();
    getImage();
  }

  getProgressDialog() {
    return new Center(child: new CircularProgressIndicator());
  }

  getBody() {
    if (showLoadingDialog) {
      return getProgressDialog();
    } else {
      return Center(
        child: _image == null
            ? Icon(
                Icons.account_circle,
                size: 150.0,
              )
            : Image.file(_image),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("上传头像"),
      ),
      body: getBody(),
      floatingActionButton: GestureDetector(
        child: ClipOval(
            child: SizedBox(
          width: 70.0,
          height: 70.0,
          // ignore: ambiguous_import
          child: Container(
            color: Colors.red,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        )),
        onTap: uploadImg,
      ),
    );
  }
}
