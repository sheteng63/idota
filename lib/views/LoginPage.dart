import 'package:flutter/material.dart';
import 'MainPage.dart';
import 'package:idota/utils/HttpUtils.dart';
import 'package:idota/utils/AppStatus.dart';
class LoginPage extends StatefulWidget {
  @override
  createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String name;

  String pwd;

  _login() async {

    int code;

    var res = await HttpUtils.getInstance().post("/user/login", data: {"username": name, "pwd": pwd});
    code = res['code'];
    print("code == $code");
    if (code == 0) {
      var token = res['token'];
      AppStatus.getInstance().saveToken(token);
      Navigator.of(context).pop(true);
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
