import 'package:flutter/material.dart';

class BlogDetailPage extends StatefulWidget {
  var blog;
  BlogDetailPage({this.blog}){

  }
  @override
  _BlogDetailPageState createState() => _BlogDetailPageState(blog: blog);
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  var blog;
  _BlogDetailPageState({this.blog}){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blog["title"]),
      ),
      body: Column(
        children: <Widget>[
          Text(blog["body"]),
        ],
      ),
    );
  }
}
