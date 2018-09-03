import 'package:flutter/material.dart';
import 'package:idota/utils/HttpUtils.dart';

class BlogDetailPage extends StatefulWidget {
  var blog;

  BlogDetailPage({this.blog}) {}

  @override
  _BlogDetailPageState createState() => _BlogDetailPageState(blog: blog);
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  var blog;

  _BlogDetailPageState({this.blog}) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: Column(
          children: <Widget>[
            new Container(
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.all(5.0),
              width: 320.0,
              decoration: new BoxDecoration(
                color: Colors.white,
                border: new Border.all(
                  color: Colors.yellow,
                  width: 1.0,
                ),
                borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text(
                          blog["body"],
                          maxLines: 1,
                          style: new TextStyle(
                              fontSize: 18.0,
                              color: Theme.of(context).primaryColor),
                        ),
                      )
                    ],
                  ),
                  Image.network(
                      HttpUtils.IMG_URL + blog['image']
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
