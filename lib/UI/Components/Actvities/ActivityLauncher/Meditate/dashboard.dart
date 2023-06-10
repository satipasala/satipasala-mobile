import 'package:flutter/material.dart';
import 'dart:async';
import 'Timer.dart';
import 'activity.dart';

class MeditateDashbaord extends StatefulWidget {
   String? uid;
  MeditateDashbaord({
     Key? key,
    this.uid,
  }) : super(key: key);

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
    _timer = new Timer.periodic(
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
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  Widget timer() {
    return Container(
      child:  Column(
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
    return new WillPopScope(
        onWillPop: () async => false,
        child: new Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff03174C),
            iconTheme: IconThemeData(color: Colors.lightBlueAccent),
            centerTitle: true,
            title: Text(
              "Practice Mindfulness",
              style: TextStyle(fontFamily: "Montserrat-Medium"),
            ),
            bottom: TabBar(
              unselectedLabelColor: Colors.white,
              labelColor: Colors.amber,
              tabs: [
                new Tab(
                  icon: Icon(Icons.timer),
                  text: "Timer",
                ),
                new Tab(
                  text: "My Activity",
                  icon: new Icon(Icons.local_activity),
                ),
              ],
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            bottomOpacity: 1,
          ),
          body: TabBarView(
            children: [
               TimerPage(uid: widget.uid),
               MyActivity(uid: widget.uid),
            ],
            controller: _tabController,
          ),
        ));
  }
}
