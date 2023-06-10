import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class MedDateTime {
  String? date;
  double? timimg;
  String? type;

  MedDateTime(String? date, double timimg, String? type) {
    this.date = date;
    this.timimg = timimg;
    this.type = type;
  }
}

class MyActivity extends StatefulWidget {
  final String? uid;
  const MyActivity({
    Key? key,
    this.uid,
  }) : super(key: key);

  @override
  _MyActivityState createState() => _MyActivityState();
}

class _MyActivityState extends State<MyActivity> {
  List<String> week = ["S", "M", "T", "W", "T", "F", "S"];
  List<MedDateTime>? medtimes;
  double progressLevel = 10;
  Timer? _timer;
  double monday = 0;
  double tuesday = 0;
  double wensday = 0;
  double thursday = 0;
  double friday = 0;
  double saturday = 0;
  double sunday = 0;

  double sitting = 0;
  double listening = 0;
  double eating = 0;
  double walking = 0;

  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    loadTimings();
    setState(() {
      isLoaded = true;
    });
  }

  void loadTimings() {
    FirebaseFirestore.instance
        .collection('timerActivity')
        .doc(_auth.currentUser?.email)
        .collection('activityTimings')
        .where('date',
            isGreaterThanOrEqualTo: DateTime.now().subtract(Duration(days: 7)))
        .get()
        .then((value) {
      setState(() {
        final List<DocumentSnapshot> documents = value.docs;
        documents.forEach((element) {
          String? day =
              DateFormat('EEEE').format(element['date'].toDate()).toLowerCase();
          String? medType = element['type'].toLowerCase();
          if (medType!.contains("sitting")) {
            sitting = sitting + element['totalTime'];
          } else if (medType.contains("listening")) {
            listening = listening + element['totalTime'];
          } else if (medType.contains("eating")) {
            eating = eating + element['totalTime'];
          } else if (medType.contains("walking")) {
            walking = walking + element['totalTime'];
          } else if (medType.contains("gaming")) {}

          if (day == "monday") {
            monday = monday + element['totalTime'];
          } else if (day == "tuesday") {
            tuesday = tuesday + element['totalTime'];
          } else if (day == "wensday") {
            wensday = wensday + element['totalTime'];
          } else if (day == "thursday") {
            thursday = thursday + element['totalTime'];
          } else if (day == "friday") {
            friday = friday + element['totalTime'];
          } else if (day == "saturday") {
            saturday = saturday + element['totalTime'];
          } else if (day == "sunday") {
            sunday = sunday + element['totalTime'];
          }
        });
        isLoaded = true;
      });
    });
  }

  Widget progressBar(context, int index, int level) {
    String? day = week[index];
    double progress = 0;
    if (index == 0) {
      progress = sunday / 1000 * 0.05;
    } else if (index == 1) {
      progress = monday / 1000 * 0.05;
    } else if (index == 2) {
      progress = tuesday / 1000 * 0.05;
    } else if (index == 3) {
      progress = wensday / 1000 * 0.05;
    } else if (index == 4) {
      progress = thursday / 1000 * 0.05;
    } else if (index == 5) {
      progress = friday / 1000 * 0.05;
    } else if (index == 6) {
      progress = saturday / 1000 * 0.05;
    }

    if (progress > 150) {
      progress = 150;
    }
    return Padding(
      padding: index == 0
          ? const EdgeInsets.only(left: 0)
          : const EdgeInsets.only(left: 30),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                height: 150.0,
                width: 10.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10)),
              ),
              Container(
                height: progress,
                width: 10.0,
                decoration: BoxDecoration(
                    color: Colors.teal,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ],
          ),
          Text(
            day,
            style:
                TextStyle(color: Colors.white, fontFamily: "Montserrat-Medium"),
          )
        ],
      ),
    );
  }

  Widget meditationActivity(String? meditationType, double time) {
    final int seconds = (time / 1000).truncate();
    final int minutes = (seconds / 60).truncate();
    final int hours = (minutes / 60).truncate();

    if (minutes == 0) {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Container(
          height: 80,
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 65, 76, 156),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      meditationType!,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: "Montserrat-Medium"),
                    ),
                    Text(
                      "${hours.toString()}hrs ${minutes.toString()}mins",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: "Montserrat-Medium"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? new SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: new Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 65, 76, 156),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10)),
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: week.length,
                            itemBuilder: (BuildContext context, int index) {
                              return progressBar(context, index, 3);
                            },
                          )
                        ],
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                Text("This Weeks Activty",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 30.0,
                      fontFamily: "Montserrat-Medium",
                      letterSpacing: 1.0,
                    )),
                SizedBox(
                  height: 30,
                ),
                sitting != 0 || listening != 0 || eating != 0 || walking != 0
                    ? Column(
                        children: <Widget>[
                          meditationActivity("Mindful Sitting", sitting),
                          meditationActivity("Mindful Listening", listening),
                          meditationActivity("Mindful Eating", eating),
                          meditationActivity("Mindful Walking", walking)
                        ],
                      )
                    : Center(
                        child: Text(
                          "No activity for this week",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black38,
                              fontFamily: "Montserrat-Medium"),
                        ),
                      ),
              ],
            ),
          )
        : new Center(child: CircularProgressIndicator());
  }
}
