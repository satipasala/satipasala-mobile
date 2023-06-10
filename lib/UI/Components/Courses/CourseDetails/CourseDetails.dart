import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile/Firebase/AuthService.dart';
import 'package:mobile/Firebase/CollectionService.dart';
import 'package:mobile/Firebase/model/Activity.dart';
import 'package:mobile/UI/Components/Home/ActionFeed/DescriptionWidget.dart';
import 'package:mobile/UI/Components/Sati/ActivityFeed/SatiActivityCard.dart';
import 'package:mobile/UI/Styles/AppStyles.dart';

import '../../../../Firebase/model/Course.dart';

class CourseDetails extends StatefulWidget {
  final CourseInfo courseInfo;

  CourseDetails({Key? key, required this.courseInfo}) : super(key: key);

  @override
  _CourseDetailsState createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails>
    with SingleTickerProviderStateMixin {
  // final List<Tab> myTabs = <Tab>[
  //   new Tab(text: 'Pick an activity'),
  //   new Tab(text: 'Comments'),
  // ];
  // TabController _controller;

  var activityMap;
  List<Activity>? activityList;
  CollectionService<Course> collectionService = CollectionService(
      "courses",
      (Map<String, dynamic> snapshot, [String? id]) =>
          Course.fromSnapshot(snapshot, id));
  Stream<Course>? courseStream;

  @override
  void initState() {
    // TODO: implement initState
    courseStream = this.collectionService.get(widget.courseInfo.id);
    super.initState();

    // _controller = new TabController(length: 2, vsync: this);
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  Widget buildActivityCards(Course? course) {
    activityMap = HashMap.from(course?.activities);
    var temp = new Map<String, dynamic>.from(activityMap);
    activityList =
        temp.entries.map((e) => Activity.fromSnapshot(e.value)).toList();
    final orientation = MediaQuery.of(context).orientation;
    return GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: activityList?.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            childAspectRatio: 0.8, maxCrossAxisExtent: 300),
        itemBuilder: (BuildContext context, int index) {
          return new GridTile(
            child: SatiActivityCard(activityList![index]),
            //just for testing, will fill with image later
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = context.read<AuthService>();

    return Scaffold(
      backgroundColor: Color(0xff03174C),
      body: SingleChildScrollView(
        child: StreamBuilder<Course>(
            stream: courseStream,
            // a previously-obtained Future<String> or null
            builder: (BuildContext context, AsyncSnapshot<Course> snapshot) {
              if (snapshot.hasData) {
                Course? course = snapshot.data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: FutureBuilder<String>(
                              future: authService
                                  .getDefaultMediaPath(course?.mediaFiles),
                              builder: (context, snapshot) =>

                                  snapshot.data != null ?  CachedNetworkImage(
                                    imageUrl: snapshot.data as String,
                                    placeholder: (context, url) => CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  )
                                      : Image.asset('assets/AdobeStock_246891185.jpeg')),
                        ),
                        Positioned(
                          top: 40,
                          left: 20.0,
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black45,
                                  size: 30,
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "COURSE",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.amberAccent,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.courseInfo.name,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 26
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              DescriptionTextWidget(
                                  text: widget.courseInfo.description as String)
                            ],
                          ),
// SizedBox(
//   height: 12,
// ),
// Row(
//   mainAxisAlignment: MainAxisAlignment.start,
//   children: [
//     Image.asset('assets/headphone.png'),
//     SizedBox(
//       width: 10,
//     ),
//     Text(
//       "2434 Enrolled",
//       textAlign: TextAlign.start,
//       style: TextStyle(
//           color: Colors.white70,
//           fontWeight: FontWeight.normal,
//           fontSize: 12),
//     ),
//   ],
// ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Activities", style: subHeadingTextStyle),
                            ],
                          ),

                          Container(
                              width: MediaQuery.of(context).size.width * 0.96,
                              child: this.buildActivityCards(course))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
// new TabBar(
//   controller: _controller,
//   tabs: myTabs,
// ),
// Expanded(
//   child: TabBarView(
//     children: [CourseActivityFeed(), Text('Person')],
//     controller: _controller,
//   ),
// ),
                  ],
                );
              } else {
                return Text("Loading...");
              }
            }),
      ),
    );
  }
}
