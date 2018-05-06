import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatelessWidget {
  WebViewPage({this.url, this.title = "nihao"});

  final String url;
  final String title;

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: url,
      appBar: new AppBar(
        title: new Text(title),

      ),
    );
  }
}
