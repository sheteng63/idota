import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'MainPage.dart';
import 'package:idota/utils/HttpUtils.dart';

class LoginPage extends StatefulWidget {
  @override
  createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String name;

  String pwd;

  _login() async {
    Map json = {"username": name, "pwd": pwd};
    int code;
//    try {
//      http
//          .post("http://192.168.30.21:8000/user/login", body: json)
//          .then((response) {
//        response.headers;
//        var json = response.body;
//        var data = JSON.decode(json);
//        code = data['code'];
//        print("code == $code");
//        if (code == 0) {
//          Navigator.push(
//            context,
//            new MaterialPageRoute(builder: (context) => new MainPage()),
//          );
//        }
//      });
//    } catch (exception) {
//      print(exception);
//    }

    String res = await HttpUtils.getInstance().get("/user/login", data: json);
    var data = JSON.decode(res);
    code = data['code'];
    print("code == $code");
    if (code == 0) {
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new MainPage()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("登录"),
      ),
      body: new Center(
        child: new Container(
          height: 400.0,
          width: 300.0,
          child: new Form(
            key: _formKey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new TextFormField(
                  decoration: new InputDecoration(labelText: "用户名"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter username';
                    }
                  },
                  style: new TextStyle(
                      fontSize: 20.0, color: Theme.of(context).primaryColor),
                  onSaved: (value) {
                    name = value;
                  },
                ),
                new TextFormField(
                  decoration: new InputDecoration(labelText: "密码"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter password';
                    }
                  },
                  style: new TextStyle(
                      fontSize: 20.0, color: Theme.of(context).primaryColor),
                  onSaved: (value) {
                    pwd = value;
                  },
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: new Column(
                    children: <Widget>[
                      new Center(
                        child: new RaisedButton(
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              print("name = $name    pwd = $pwd");
                              _login();
                            }
                          },
                          child: new Center(child: new Text('登录')),
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: new Align(
                          alignment: FractionalOffset.centerRight,
                          child: new GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('/resgiter');
                            },
                            child: new Text(
                              "注册",
                              style: new TextStyle(
                                  fontSize: 14.0,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
