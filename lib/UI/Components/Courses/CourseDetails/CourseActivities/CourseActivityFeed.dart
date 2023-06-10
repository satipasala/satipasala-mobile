import 'package:flutter/material.dart';
import '../CourseActivities/CourseActivtyCard.dart';

class CourseActivityFeed extends StatefulWidget {
  @override
  _CourseActivityFeedState createState() => _CourseActivityFeedState();
}

class _CourseActivityFeedState extends State<CourseActivityFeed> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CourseActivityCard(),
        CourseActivityCard(),
      ],
    );
  }
}
