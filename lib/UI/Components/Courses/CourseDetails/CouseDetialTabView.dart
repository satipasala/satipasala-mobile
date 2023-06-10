import 'package:flutter/material.dart';

class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({Key? key}) : super(key: key);

  @override
  _MyTabbedPageState createState() => new _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    new Tab(text: 'LEFT'),
    new Tab(text: 'RIGHT'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title:  Text("Tab demo"),
        bottom:  TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      body:  TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          return  Center(child:  Text(tab.text??''));
        }).toList(),
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: () => _tabController
            .animateTo((_tabController.index + 1) % 2), // Switch tabs
        child: new Icon(Icons.swap_horiz),
      ),
    );
  }
}
