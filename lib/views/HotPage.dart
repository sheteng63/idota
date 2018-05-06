import 'package:flutter/material.dart';
import 'WebViewPage.dart';

class HotPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.all(5.0),
          padding:const EdgeInsets.all(5.0) ,
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
                child: new IconButton(
                  icon: new Icon(
                    Icons.arrow_forward,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (BuildContext context) {
                      return new WebViewPage(
                        url: "http://www.baidu.com",

                      );
                    }));
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
