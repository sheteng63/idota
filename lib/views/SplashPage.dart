import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'MainPage.dart';

class SplashPage extends StatefulWidget {
  @override
  createState() => new SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String name;

  String pwd;

  _login() async {
    Map json = {"username": name, "pwd": pwd};
    int code;
    try {
      http.post("http://192.168.30.21:8000/user/login", body: json)
          .then((response) {
        var json = response.body;
        var data = JSON.decode(json);
        code = data['code'];
        print("code == $code");
        if (code == 0) {
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new MainPage()),
          );
        }
      });
    } catch (exception) {}
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
      body: new Container(
        child: new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Form(
            key: _formKey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter username';
                    }
                  },
                  style: new TextStyle(
                      fontSize: 20.0
                  ),
                  onSaved: (value) {
                    name = value;
                  },
                ),
                new TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter password';
                    }
                  },
                  style: new TextStyle(
                    fontSize: 20.0
                  ),
                  onSaved: (value) {
                    pwd = value;
                  },
                ),
                new Center(
                  child: new Padding(
                    padding: const EdgeInsets.all( 16.0),
                    child: new RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          print("name = $name    pwd = $pwd");
                        }
                        _login();
                      },
                      child: new Text('登录'),
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
