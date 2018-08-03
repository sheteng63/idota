import 'package:flutter/material.dart';
import 'views/WebViewPage.dart';
import 'views/LoginPage.dart';
import 'views/ResgiterPage.dart';
import 'views/MainPage.dart';

void main() {
  runApp(new MaterialApp(
    routes: {
      "/a": (_) => new WebViewPage(
            url: "https://www.baidu.com",
            title: "baidu",
          ),
      "/resgiter": (_) => new ResgiterPage()
    },
    title: 'Flutter Demo',
    home: new MainPage(),
  ));
}
