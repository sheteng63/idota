import 'package:flutter/material.dart';
import 'WebViewPage.dart';
import 'dart:async';

class HotPage extends StatefulWidget {
  @override
  _HotPageState createState() => _HotPageState();
}

class _HotPageState extends State<HotPage> {
  int index = 10;

  Widget _builItem(BuildContext context, int index) {
    return new GestureDetector(
      child: new Container(
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.all(5.0),
        height: 150.0,
        decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new NetworkImage(
                  "http://c.hiphotos.baidu.com/image/h%3D300/sign=e3b76ad36081800a71e58f0e813433d6/d50735fae6cd7b89acbea9df032442a7d8330e9f.jpg",
                ),
                fit: BoxFit.cover)),
        child: new Row(
          children: <Widget>[
            new Flexible(
              flex: 4,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Flexible(
                    child: new Text(
                      "NATIVEONDRAW",
                      style: new TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).primaryColor),
                    ),
                    flex: 1,
                  ),
                  new Flexible(
                    flex: 1,
                    child: new Text(
                      "nativeOnDraw failed; clearing to background color",
                      style: new TextStyle(fontSize: 15.0),
                    ),
                  )
                ],
              ),
            ),
            new Flexible(
              flex: 1,
              child: new Icon(
                Icons.arrow_forward,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator
            .of(context)
            .push(new MaterialPageRoute(builder: (BuildContext context) {
          return new WebViewPage(
            url: "http://www.wanmei.com",
            title: "完美",
          );
        }));
      },
    );
  }

  Future<Null> _onRefresh() async {
    print("下拉刷新");
    setState(() {
      index = 10;
    });
  }

  var _scrollCon = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollCon.addListener(() {
      if (_scrollCon.position.pixels == _scrollCon.position.maxScrollExtent) {
        print("加载更多");
        setState(() {
          index += 10;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollCon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: new ListView.builder(
        itemCount: index,
        itemBuilder: _builItem,
        controller: _scrollCon,
      ),
      onRefresh: _onRefresh,
    );
  }
}
