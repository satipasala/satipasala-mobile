import 'package:flutter/material.dart';
import 'dart:async';
import 'Timer.dart';
import 'activity.dart';

class MeditateDashbaord extends StatefulWidget {
  @override
  _MeditateDashbaordState createState() => _MeditateDashbaordState();
}

class _MeditateDashbaordState extends State<MeditateDashbaord>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late Timer _timer;
  int _start = 0;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 0) {
            timer.cancel();
          } else {
            _start = _start + 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  Widget timer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(_start.toString()),
          ElevatedButton(
            onPressed: () {
              startTimer();
            },
            child: Text("Start"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lightBlueAccent,
            iconTheme: const IconThemeData(color: Colors.lightBlueAccent),
            centerTitle: true,
            title: const Text(
              "Meditate",
              style: TextStyle(fontFamily: "Montserrat-Medium"),
            ),
            bottom: TabBar(
              unselectedLabelColor: Colors.white,
              labelColor: Colors.amber,
              tabs: const [
                Tab(
                  icon: Icon(Icons.timer),
                  text: "Timer",
                ),
                Tab(
                  text: "My Activity",
                  icon:  Icon(Icons.local_activity),
                ),
              ],
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            bottomOpacity: 1,
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              const TimerPage(),
              MyActivity(),
            ],
          ),
        ));
  }
}
