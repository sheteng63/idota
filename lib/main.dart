import 'package:flutter/material.dart';
import 'views/WebViewPage.dart';
import 'views/SplashPage.dart';
void main() {
  runApp(new MaterialApp(
    routes: {
      "/a": (_) => new WebViewPage(url:"https://www.baidu.com",title: "baidu",)
    },
    title: 'Flutter Demo',
    home: new SplashPage(),
  ));
}




