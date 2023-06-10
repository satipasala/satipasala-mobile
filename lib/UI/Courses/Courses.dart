import 'package:flutter/material.dart';
import '../Styles/AppStyles.dart';
import '../Components/Courses/CourseFeed/CourseFeed.dart';

class Courses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScrollController   scrollController = ScrollController();
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: SingleChildScrollView(
        controller: scrollController,
        child: Container(
          padding: EdgeInsets.only(left: 20, top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Courses", style: headerTextStyle),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CourseFeed(scrollController),
            ],
          ),
        ),
      ),
    );
  }
}
