import 'dart:io';
import 'package:flutter/material.dart';
import 'package:idota/views/NewBlogPage.dart';
import 'package:idota/views/UploadImagePage.dart';
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
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return UploadImagePage();
    }));
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
      if (mounted) {
        setState(() {});
      }
    } else {}
  }

  void _login() async {
    Navigator.of(context)
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                      // ignore: ambiguous_import
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
                          color: Theme
                              .of(context)
                              .primaryColor),
                      child: new Text(
                        '新心情',
                        style: new TextStyle(
                            color: Theme
                                .of(context)
                                .primaryColor),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return NewBlogPage();
                        }));
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
                          color: Theme
                              .of(context)
                              .primaryColor),
                      child: new Text(
                        '我参与的',
                        style: new TextStyle(
                            color: Theme
                                .of(context)
                                .primaryColor),
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
                          color: Theme
                              .of(context)
                              .primaryColor),
                      child: new Text(
                        '关注记录',
                        style: new TextStyle(
                            color: Theme
                                .of(context)
                                .primaryColor),
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
                          color: Theme
                              .of(context)
                              .primaryColor),
                      child: new Text(
                        '浏览历史',
                        style: new TextStyle(
                            color: Theme
                                .of(context)
                                .primaryColor),
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
                          color: Theme
                              .of(context)
                              .primaryColor),
                      child: new Text(
                        '退出登录',
                        style: new TextStyle(
                            color: Theme
                                .of(context)
                                .primaryColor),
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
                          color: Theme
                              .of(context)
                              .primaryColor),
                      child: new Text(
                        '点击登录',
                        style: new TextStyle(
                            color: Theme
                                .of(context)
                                .primaryColor),
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
