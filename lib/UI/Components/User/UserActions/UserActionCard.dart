import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile/Firebase/AuthService.dart';
import 'package:mobile/Firebase/model/Action.dart';
import 'package:mobile/Firebase/model/Course.dart';
import 'package:mobile/Firebase/model/User.dart';
import 'package:mobile/UI/Components/Courses/CourseDetails/CourseDetails.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

class UserActionCard extends StatefulWidget {
  final UserAction userActions;

  const UserActionCard(this.userActions);

  @override
  _UserActionCardState createState() => _UserActionCardState();
}

class _UserActionCardState extends State<UserActionCard> {
  String image = "";
  String title = "";
  CourseInfo course;
  List<User> users;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    title = widget.userActions.actionType
        .replaceAll('_', ' ')
        .toString()
        .trim()
        .capitalize();
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = context.read<AuthService>();
    Future<String> defaultImagePath;
    if (widget.userActions.actionType.contains("session")) {
      image = "assets/event.jpeg";
    } else if (widget.userActions.actionType.contains("program")) {
      image = "assets/AdobeStock_224390624.jpeg"; //program.mediaFiles.defaultMedia.link
    } else if (widget.userActions.actionType.contains("course")) {
      image = "assets/AdobeStock_246891185.jpeg"; //course.mediaFiles.defaultMedia.link
      course = CourseInfo.fromSnapshot(widget.userActions.record);
      defaultImagePath = authService.getDefaultMediaPath(course.mediaFiles);
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      NetworkImage(widget.userActions.user.photoURL)),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.userActions.user.displayName,
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  Text(widget.userActions.user.userRole.name,
                      style: TextStyle(fontSize: 12, color: Colors.grey))
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 3,
              ),
              Text(title,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontStyle: FontStyle.italic)),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          new InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseDetails(courseInfo: course),
                  ));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: FutureBuilder<String>(
                  future: defaultImagePath,
                  builder: (context, snapshot) => snapshot.data != null
                      ? Image.network(
                          snapshot.data,
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.9,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          image,
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.9,
                          fit: BoxFit.cover,
                        )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // Row(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(right: 10),
          //       child: Icon(
          //         Icons.filter_vintage,
          //         color: Colors.amber,
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(right: 10),
          //       child: Text(
          //         "Level 01",
          //         style: TextStyle(color: Colors.grey),
          //       ),
          //     ),
          //     Text(
          //       "#tags",
          //       style: TextStyle(color: Colors.blueAccent),
          //     )
          //   ],
          // ),
          // Container(
          //   padding: EdgeInsets.all(5),
          //   width: MediaQuery.of(context).size.width * 0.9,
          //   child: DescriptionTextWidget(
          //       text:
          //           "this is a sample text to test out the description widget feature and the show more button feature testing testing testing"),
          // )
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
