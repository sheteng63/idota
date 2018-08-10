import 'HotPage.dart';
import 'AccountPage.dart';
import 'AttentionPage.dart';
import 'package:flutter/material.dart';
import 'package:idota/utils/AppStatus.dart';

class MainPage extends StatefulWidget {
	@override
	createState() => new MainPageState();
}
class MainPageState extends State<MainPage>
	with SingleTickerProviderStateMixin {
	TabController tabController;
	
	@override
	void initState() {
		super.initState();
		tabController = new TabController(length: 3, vsync: this);
		AppStatus.getInstance().initHeader();
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