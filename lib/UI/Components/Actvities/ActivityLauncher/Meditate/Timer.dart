import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:flutter_isolate/flutter_isolate.dart';
import 'dart:isolate';
import 'dart:io'; // for exit();
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance; 

class ElapsedTime {
  final int hundreds;
  final int seconds;
  final int minutes;

  ElapsedTime({
    required this.hundreds,
    required this.seconds,
    required this.minutes,
  });
}

class Dependencies {
  final List<ValueChanged<ElapsedTime>> timerListeners =
      <ValueChanged<ElapsedTime>>[];
  final TextStyle textStyle = const TextStyle(
      color: Colors.white, fontSize: 60.0, fontFamily: "Bebas Neue");
  final Stopwatch stopwatch = new Stopwatch();
  final int timerMillisecondsRefreshRate = 30;
}

class TimerPage extends StatefulWidget {
  final String? uid;
  const TimerPage({
     Key? key,
    this.uid,
  }) : super(key: key);

  TimerPageState createState() => new TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  final Dependencies dependencies = new Dependencies();
  FirebaseFirestore dbInstance = FirebaseFirestore.instance; 
  bool resetBtn = false;
  bool saveBtn = false;
  bool startBtn = false;
  bool stopBtn = false;
  bool loading = false;
  String textHint = "Select Type";
  bool textHintStatus = false;
  late Isolate isolate;

  void leftButtonPressed() {
    setState(() {
      saveBtn = false;
      resetBtn = true;
      dependencies.stopwatch.reset();
    });
  }

  void saveButtonPressed() {
    setState(() {
      saveBtn = false;
      loading = true;
    });
 
    dbInstance
        .collection('timerActivity')
        .doc(_auth.currentUser?.email)
        .collection('activityTimings')
        .doc()
        .set({
      'type': textHint,
      'totalTime': dependencies.stopwatch.elapsedMilliseconds,
      'date': DateTime.now()
    }).then((value) {
      dependencies.stopwatch.reset(); 
      setState(() {
        loading = false;
      });
    });
  }

  void rightButtonPressed() async {
    setState(() {
      if (dependencies.stopwatch.isRunning) {
        stopBtn = true;
        saveBtn = true;
        dependencies.stopwatch.stop();
      } else {
        if (textHint.toLowerCase().contains("select")) {
          textHintStatus = true;
        } else {
          dependencies.stopwatch.start();
          startBtn = true;
          stopBtn = false;
          textHintStatus = false;
        }
      }
    });
  }

  Widget buildFloatingButton(String text, VoidCallback callback) {
    TextStyle roundTextStyle =
        const TextStyle(fontSize: 16.0, color: Colors.white);
    return new FloatingActionButton(
        backgroundColor:
            text.toLowerCase() == "reset" ? Colors.green : Colors.redAccent,
        child: new Text(text, style: roundTextStyle),
        onPressed: callback);
  }

  Widget buildSaveFloatingButton(String text, VoidCallback callback) {
    TextStyle roundTextStyle =
        const TextStyle(fontSize: 16.0, color: Colors.white);
    return new FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        child: new Text(text, style: roundTextStyle),
        onPressed: callback);
  }

  Widget dropDown() {
    return  DropdownButton<String>(
      style: TextStyle(
          fontSize: 15, color: Colors.black54, fontFamily: "Montserrat-Medium"),
      hint: Text(
        textHint,
        style:
            TextStyle(color: textHintStatus ? Colors.redAccent : Colors.white),
      ),
      items: <String>[
        'Mindful Sitting',
        'Mindful Listening',
        'Mindful Eating',
        'Mindful Walking'
      ].map((String value) {
        return  DropdownMenuItem<String>(
          value: value,
          child:  Text(value),
        );
      }).toList(),
      onChanged: (_value) {
        setState(() {
          textHint = _value!;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {  
    return Container(
      color: Color(0xff2b315e),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 20),
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.6,
            child: new Image.asset("assets/meditationgif.gif"),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          TimerText(dependencies: dependencies),
           Padding(
            padding: const EdgeInsets.only(top: 10),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildFloatingButton("reset", leftButtonPressed),
                saveBtn
                    ? buildSaveFloatingButton("save", saveButtonPressed)
                    : dependencies.stopwatch.isRunning
                        ? Container()
                        : dropDown(),
                buildFloatingButton(
                    dependencies.stopwatch.isRunning ? "stop" : "start",
                    rightButtonPressed),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TimerText extends StatefulWidget {
  const TimerText({required this.dependencies});
  final Dependencies dependencies;

  TimerTextState createState() =>
      new TimerTextState(dependencies: dependencies);
}

class TimerTextState extends State<TimerText> {
  TimerTextState({required this.dependencies});
  final Dependencies dependencies;
  Timer? timer;
  int? milliseconds;

  @override
  void initState() {
    timer =  Timer.periodic(
         Duration(milliseconds: dependencies.timerMillisecondsRefreshRate),
        callback);
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  void callback(Timer timer) {
    if (milliseconds != dependencies.stopwatch.elapsedMilliseconds) {
      milliseconds = dependencies.stopwatch.elapsedMilliseconds;
      final int hundreds = (milliseconds! / 10).truncate();
      final int seconds = (hundreds / 100).truncate();
      final int minutes = (seconds / 60).truncate();
      final ElapsedTime elapsedTime = new ElapsedTime(
        hundreds: hundreds,
        seconds: seconds,
        minutes: minutes,
      );
      for (final listener in dependencies.timerListeners) {
        listener(elapsedTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RepaintBoundary(
          child:  SizedBox(
            height: 100.0,
            child:  MinutesAndSeconds(dependencies: dependencies),
          ),
        ),
         RepaintBoundary(
          child:  SizedBox(
            height: 100.0,
            child:  Hundreds(dependencies: dependencies),
          ),
        ),
      ],
    );
  }
}

class MinutesAndSeconds extends StatefulWidget {
  MinutesAndSeconds({required this.dependencies});
  final Dependencies dependencies;

  MinutesAndSecondsState createState() =>
      new MinutesAndSecondsState(dependencies: dependencies);
}

class MinutesAndSecondsState extends State<MinutesAndSeconds> {
  MinutesAndSecondsState({required this.dependencies});
  final Dependencies dependencies;

  int minutes = 0;
  int seconds = 0;

  @override
  void initState() {
    dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.minutes != minutes || elapsed.seconds != seconds) {
      setState(() {
        minutes = elapsed.minutes;
        seconds = elapsed.seconds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    return new Text('$minutesStr:$secondsStr.', style: dependencies.textStyle);
  }
}

class Hundreds extends StatefulWidget {
  Hundreds({required this.dependencies});
  final Dependencies dependencies;

  HundredsState createState() => new HundredsState(dependencies: dependencies);
}

class HundredsState extends State<Hundreds> {
  HundredsState({required this.dependencies});
  final Dependencies dependencies;

  int hundreds = 0;

  @override
  void initState() {
    dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.hundreds != hundreds) {
      setState(() {
        hundreds = elapsed.hundreds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');
    return new Text(hundredsStr, style: dependencies.textStyle);
  }
}
