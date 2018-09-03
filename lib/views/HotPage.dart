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
        if (mounted) {
          setState(() {});
        }
      }
    }
  }

  Widget _builItem(BuildContext context, int index) {
    var blog = blogs[index];
    return new Container(
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
          Row(
            children: <Widget>[
              blog["authorImg"] != null
                  ? ClipOval(
                      child: SizedBox(
                      width: 20.0,
                      height: 20.0,
                      child: Image.network(
                        HttpUtils.IMG_URL + blog["authorImg"],
                      ),
                    ))
                  : Icon(
                      Icons.account_circle,
                      size: 20.0,
                    ),
              Expanded(
                child: Text(
                  blog["authorName"],
                  maxLines: 1,
                ),
              ),
              Text(
                blog['date'],
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          GestureDetector(
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
            onTap: () {
              Navigator.of(context)
                  .push(new MaterialPageRoute(builder: (BuildContext context) {
                return BlogDetailPage(blog: blog);
              }));
              _pageView(blog["id"]);
            },
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
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
              ),
              GestureDetector(
                child: Row(
                  children: <Widget>[
                    Text(blog["favorite"].toString(),
                        style: new TextStyle(fontSize: 12.0)),
                    blog['favorite'] > 0
                        ? Icon(
                            Icons.favorite,
                            size: 12.0,
                            color: Colors.redAccent,
                          )
                        : Icon(
                            Icons.favorite_border,
                            size: 12.0,
                            color: Colors.redAccent,
                          )
                  ],
                ),
                onTap: () {
                  _favorite(blog["id"]);
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Future<Null> _onRefresh() async {
    print("下拉刷新");
    blogs.clear();
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
