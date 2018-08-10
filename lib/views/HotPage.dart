import 'package:flutter/material.dart';
import 'package:idota/views/BlogDetailPage.dart';
import 'dart:async';
import 'package:idota/utils/HttpUtils.dart';

class HotPage extends StatefulWidget {
  @override
  _HotPageState createState() => _HotPageState();
}

class _HotPageState extends State<HotPage> {
  int index = 10;
  List blogs = List();

  _favorite(id) async {
    print("_favorite");
    await HttpUtils.getInstance().post("/blog/favorite", data: {"id": id});
    setState(() {});
  }

  _getData() async {
    var json = await HttpUtils.getInstance().get("/blog/list");
    print(json);
    if (json['code'] == 0) {
      var listBlog = json['content'];
      if (listBlog != null) {
        for (var blog in listBlog) {
          blogs.add(blog);
        }
        setState(() {});
      }
    }
  }

  Widget _builItem(BuildContext context, int index) {
    var blog = blogs[index];
    return new GestureDetector(
      child: new Container(
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.all(5.0),
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border.all(
            color: Colors.yellow,
            width: 1.0,
          ),
          borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
        ),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              blog["title"],
              style: new TextStyle(
                  fontSize: 18.0, color: Theme.of(context).primaryColor),
            ),
            new Text(
              blog["body"],
              maxLines: 2,
              style: new TextStyle(fontSize: 15.0),
            ),
            Align(
              alignment: FractionalOffset.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        blog["pageViews"].toString(),
                        style: new TextStyle(fontSize: 12.0),
                      ),
                      Icon(
                        Icons.remove_red_eye,
                        color: Theme.of(context).primaryColor,
                        size: 12.0,
                      ),
                    ],
                  ),
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Text(blog["favorite"].toString(),
                            style: new TextStyle(fontSize: 12.0)),
                        Icon(
                          Icons.favorite_border,
                          size: 12.0,
                        ),
                      ],
                    ),
                    onTap: () {
                      _favorite(blog["id"]);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator
            .of(context)
            .push(new MaterialPageRoute(builder: (BuildContext context) {
          return BlogDetailPage(blog: blog);
        }));
        _pageView(blog["id"]);
      },
    );
  }

  Future<Null> _onRefresh() async {
    print("下拉刷新");
    setState(() {
      blogs.clear();
    });
    _getData();
  }

  var _scrollCon = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollCon.addListener(() {
      if (_scrollCon.position.pixels == _scrollCon.position.maxScrollExtent) {
        print("加载更多");
//        setState(() {
//          index += 10;
//        });
      }
    });
    blogs.clear();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollCon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: new ListView.builder(
        itemCount: blogs.length,
        itemBuilder: _builItem,
        controller: _scrollCon,
      ),
      onRefresh: _onRefresh,
    );
  }

  _pageView(id) async {
    var json =
        await HttpUtils.getInstance().post("/blog/pageView", data: {"id": id});
  }
}
