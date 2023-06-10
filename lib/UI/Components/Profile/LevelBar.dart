import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class LevelBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new LinearPercentIndicator(
      width: 250.0,
      lineHeight: 14.0,
      percent: 0.5,
      backgroundColor: Color(0xff93A1ED),
      progressColor: Color(0xff74C7E5),
    );
  }
}
