import 'package:flutter/material.dart';
import 'package:idota/utils/AppStatus.dart';
import 'package:idota/views/LoginPage.dart';

class AttentionPage extends StatefulWidget {
  @override
  _AttentionPageState createState() => _AttentionPageState();
}

class _AttentionPageState extends State<AttentionPage> {
  bool _islogin = false;

  void _isLogin() async {
    _islogin = AppStatus.getInstance().isLogin();
    setState(() {});
  }

  void _login() async {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return LoginPage();
    })).then((value) {
      if (value != null) {
        _islogin = value;
        setState(() {});
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
        ? Center()
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
