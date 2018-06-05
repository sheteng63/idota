import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'MainPage.dart';

class ResgiterPage extends StatefulWidget {
  @override
  createState() => new ResgiterPageState();
}

class ResgiterPageState extends State<ResgiterPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String name;
  String email;
  String pwd;

  _resgiter() async {
    Map json = {"username": name, "pwd": pwd, "email": email};
    int code;
    try {
      http
          .post("http://192.168.30.21:8000/user/resgiter", body: json)
          .then((response) {
        response.headers;
        var json = response.body;
        var data = JSON.decode(json);
        code = data['code'];
        print("code == $code");
        if (code == 0) {
          Navigator.pop(context);
        } else {
          print(data['msg']);
        }
      });
    } catch (exception) {
      print(exception);
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
        title: new Text("注册"),
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
                new TextFormField(
                  decoration: new InputDecoration(labelText: "邮箱"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter email';
                    }
                  },
                  style: new TextStyle(
                      fontSize: 20.0, color: Theme.of(context).primaryColor),
                  onSaved: (value) {
                    email = value;
                  },
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: new Center(
                    child: new RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          _resgiter();
                        }
                      },
                      child: new Center(child: new Text('注册')),
                    ),
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
