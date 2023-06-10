import 'package:flutter/material.dart';
import '../Styles/AppStyles.dart';
import '../Components/Sati/CourseFeed/CourseFeed.dart';
import '../Components/Sati/ActivityFeed/SatiActivityFeed.dart';

class Sati extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Lets Practice Sati", style: headerTextStyle),
              SizedBox(
                height: 20,
              ),
              SatiCourseFeed(),
              SizedBox(
                height: 20,
              ),
              Text("Activities for you", style: headerTextStyle),
              SizedBox(
                height: 20,
              ),
              SatiActivityFeed(),
            ],
          ),
        ),
      ),
    );
  }
}
