import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:idota/utils/AppStatus.dart';
import 'LoginPage.dart';
import 'package:idota/utils/HttpUtils.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _islogin = false;
  String _name = "";
  String _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    var res = await HttpUtils.getInstance().post("/user/uploadImg",
        data: {'img': new UploadFileInfo(image, "upload.jpg")});
    String tRes = "上传失败";
    if (res['code'] == 0) {
      tRes = "上传成功";
    }
    Scaffold.of(context).showSnackBar(new SnackBar(
          content: Text(tRes),
        ));
  }

  void _isLogin() async {
    _islogin = AppStatus.getInstance().isLogin();
    if (_islogin) {
      _getUserInfo();
    } else {
      _image = null;
      setState(() {});
    }
  }

  void _getUserInfo() async {
    var res = await HttpUtils.getInstance().get("/user/info");
    print(res);
    if (res['code'] == 0) {
      this._name = res['data']['name'];
      this._image = res['data']['img'];
      setState(() {});
    } else {
      Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text('获取个人信息失败'),
          ));
    }
  }

  void _login() async {
    Navigator
        .of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return LoginPage();
    })).then((value) {
      if (value != null) {
        _islogin = value;
        _getUserInfo();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return _islogin
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    GestureDetector(
                      child: _image == null
                          ? Icon(
                              Icons.account_circle,
                              size: 70.0,
                            )
                          : ClipOval(
                              child: SizedBox(
                              width: 70.0,
                              height: 70.0,
                              child: Image.network(HttpUtils.IMG_URL + _image),
                            )),
                      onTap: getImage,
                    ),
                    Flexible(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                _name,
                                maxLines: 1,
                              ),
                              Text(
                                "签名",
                                maxLines: 1,
                              )
                            ],
                          )),
                    )
                  ],
                ),
                new Padding(
                  padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                          child: new OutlineButton(
                            borderSide: new BorderSide(
                                color: Theme.of(context).primaryColor),
                            child: new Text(
                              '新心情',
                              style: new TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            onPressed: () {

                            },
                          )),
                    ],
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                          child: new OutlineButton(
                        borderSide: new BorderSide(
                            color: Theme.of(context).primaryColor),
                        child: new Text(
                          '我参与的',
                          style: new TextStyle(
                              color: Theme.of(context).primaryColor),
                        ),
                        onPressed: () {},
                      )),

                    ],
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                          child: new OutlineButton(
                        borderSide: new BorderSide(
                            color: Theme.of(context).primaryColor),
                        child: new Text(
                          '关注记录',
                          style: new TextStyle(
                              color: Theme.of(context).primaryColor),
                        ),
                        onPressed: () {},
                      )),
                    ],
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                          child: new OutlineButton(
                        borderSide: new BorderSide(
                            color: Theme.of(context).primaryColor),
                        child: new Text(
                          '浏览历史',
                          style: new TextStyle(
                              color: Theme.of(context).primaryColor),
                        ),
                        onPressed: () {},
                      )),
                    ],
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                          child: new OutlineButton(
                        borderSide: new BorderSide(
                            color: Theme.of(context).primaryColor),
                        child: new Text(
                          '退出登录',
                          style: new TextStyle(
                              color: Theme.of(context).primaryColor),
                        ),
                        onPressed: () {
                          AppStatus.getInstance().clearToken();
                          _isLogin();
                        },
                      )),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.account_circle,
                  size: 70.0,
                ),
                Padding(
                  padding: new EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 10.0),
                  child: Row(
                    children: <Widget>[
                      new Expanded(
                          child: new OutlineButton(
                            borderSide: new BorderSide(
                                color: Theme.of(context).primaryColor),
                            child: new Text(
                              '点击登录',
                              style: new TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            onPressed: _login,
                          )),
                    ],
                  ),
                )

              ],
            ),
          );
  }
}
