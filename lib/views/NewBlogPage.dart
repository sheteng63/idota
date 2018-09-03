import 'dart:async';
import 'dart:io';
import 'package:image_compress/image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idota/utils/HttpUtils.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class NewBlogPage extends StatefulWidget {
  @override
  _NewBlogPageState createState() => _NewBlogPageState();
}

class _NewBlogPageState extends State<NewBlogPage> {
  String title;
  String body;
  File _image;

  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("新心情"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black87,
              ),
              onChanged: (s) {
                body = s;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: _image == null
                  ? GestureDetector(
                      child: Icon(
                        Icons.add,
                        color: Theme.of(context).primaryColor,
                        size: 150.0,
                      ),
                      onTap: _getImage,
                    )
                  : Image.file(
                      _image,
                      width: 320.0,
                      height: 300.0,
                      fit: BoxFit.fill,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: new RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: _newBlog,
                child: new Center(child: new Text('发表')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _newBlog() async {
    if (_image == null || body == null) {
      Fluttertoast.showToast(
          msg: "参数为空",
          toastLength: Toast.LENGTH_SHORT,
          bgcolor: "#e74c3c",
          textcolor: '#ffffff');
      return;
    }

    var file = await _getLocalFile();
    await ImageCompress.compressImageToFile(_image.path, file);

    var res = await HttpUtils.getInstance()
        .post("/blog/add", data: {'img': UploadFileInfo(file, "upload.jpg"), "body": body});
    var s = "发布失败";
    print(res);
    if (res['code'] == 0) {
      s = "发布成功";
      Navigator.of(context).pop();
    }

    Fluttertoast.showToast(
        msg: s,
        toastLength: Toast.LENGTH_SHORT,
        bgcolor: "#e74c3c",
        textcolor: '#ffffff');
  }

  Future<File> _getLocalFile() async {
    // 获取本地文档目录
    String dir = (await getApplicationDocumentsDirectory()).path;
    // 返回本地文件目录
    return new File('$dir/counter.jpg');
  }
}
