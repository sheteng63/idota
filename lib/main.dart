import 'package:flutter/material.dart';
import 'views/HotPage.dart';
import 'views/AccountPage.dart';
import 'views/AttentionPage.dart';
import 'views/WebViewPage.dart';
void main() {
  runApp(new MaterialApp(
    routes: {
      "/a": (_) => new WebViewPage(url:"https://www.baidu.com",title: "baidu",)
    },
    title: 'Flutter Demo',
    home: new ListViewSample(),
  ));
}

class ListViewSample extends StatefulWidget {
  @override
  createState() => new ListViewSampleState();
}

class ListViewSampleState extends State<ListViewSample>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("i"),
      ),
      body: new TabBarView(
        children: <Widget>[
          new HotPage(),
          new AttentionPage(),
          new AccountPage()
        ],
        controller: tabController,
        physics: new NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
            icon: new Icon(Icons.add_a_photo),
            title: new Text("热点"),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.account_balance_wallet),
            title: new Text("关注"),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.account_balance),
            title: new Text("我"),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ],
        onTap: (int index) {
          setState(() {
            tabController.index = index;
          });
        },
        currentIndex: tabController.index,
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}
