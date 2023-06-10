import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mobile/Actions/Subscription/Subscribe.dart';
import 'package:mobile/Firebase/CollectionService.dart';
import 'package:mobile/Firebase/model/Course.dart';
import 'package:mobile/Firebase/model/EventSession.dart';
import 'package:mobile/UI/Components/Camera/camera.dart';
import 'package:mobile/UI/Components/Camera/utils/image_picker_helper.dart';
import 'package:mobile/UI/Components/Camera/verify.dart';
import 'package:mobile/UI/Components/Courses/CourseCard/CourseCard.dart';
import '../../../../Firebase/AuthService.dart';
import '../../../Styles/AppStyles.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class EventSessionDetails extends StatefulWidget {
  final EventSession event;

  const EventSessionDetails(this.event);

  @override
  _EventSessionDetailsState createState() => _EventSessionDetailsState();
}

class _EventSessionDetailsState extends State<EventSessionDetails> {
  late List<Course> courseInfo;
  bool isSubbed = false;
  bool isButtonLoading = true;
  late AuthService _auth;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late User _user;
  CollectionService<EventSession> collectionService = CollectionService(
      "eventSessions",
      (Map<String, dynamic> snapshot, [String? id]) =>
          EventSession.fromSnapshot(snapshot));
  late Stream<EventSession> programStream;

  @override
  void initState() {
    var imgUrls = widget.event.imgUrls;
    print(imgUrls);

    // TODO: implement initState
    this.programStream = this.collectionService.get(widget.event.id);
    _auth = new AuthService(_firebaseAuth);
    _auth.getCurrentUser().then((value) {
      _user = value;
    }).then((value) {
      IsSubbedToSession(widget.event, _user.email as String).then((value) {
        setState(() {
          isSubbed = value;
          isButtonLoading = false;
        });
      });
    });
    super.initState();
  }

  Widget buildCourseCards(EventSession? session) {
    courseInfo = session!.program.courses
        .where((element) => element.active != null
            ? element.active?.toLowerCase() == "yes"
            : false)
        .toList();
    return GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: courseInfo.length,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(child: CourseCard(courseInfo[index]));
        });
  }

  List<Widget> buildImageSlideShow() {
    List<Widget> widgetArray = [];
    for (int i = 0; i < widget.event.imgUrls.length; i++) {
      widgetArray
          .add(Image.network(widget.event.imgUrls[i], fit: BoxFit.cover));
    }
    return widgetArray;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff03174C),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                widget.event.imgUrls.length > 0
                    ? ImageSlideshow(
                        width: double.infinity,
                        height: 200,
                        initialPage: 0,
                        indicatorColor: Colors.blue,
                        indicatorBackgroundColor: Colors.grey,
                        onPageChanged: (value) {
                          debugPrint('Page changed: $value');
                        },
                        isLoop: true,
                        autoPlayInterval: 5000,
                        children: buildImageSlideShow())
                    : Image.asset('assets/event.jpeg'),

                //Image.asset('assets/event.jpeg'),

                Positioned(
                  top: 40.0,
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
                // Positioned(
                //   top: 180,
                //   left: MediaQuery.of(context).size.width * 0.75,
                //   child: !isButtonLoading
                //       ? Container(
                //           child: TextButton(
                //             style: ButtonStyle(
                //                 backgroundColor:
                //                     MaterialStateProperty.all<Color>(!isSubbed
                //                         ? Colors.amber[600]
                //                         : Colors.green[600]),
                //                 shape: MaterialStateProperty.all<
                //                         RoundedRectangleBorder>(
                //                     RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(18.0),
                //                 ))),
                //             onPressed: () {
                //               if (!isSubbed) {
                //                 SubscribeToAction(widget.event, _user.email)
                //                     .then((value) {
                //                   setState(() {
                //                     isSubbed = true;
                //                   });
                //                 });
                //               }
                //             },
                //             child: Row(
                //               mainAxisAlignment:MainAxisAlignment.center,
                //               children: [
                //                  Container(
                //                      child:  Text(
                //                        isSubbed ? "ENROLLED" : "ENROLL",
                //                        style: TextStyle(
                //                            color: Colors.white, fontSize: 11),
                //                      ) ),

                //               ],
                //             ),
                //           ),
                //         )
                //       : CircularProgressIndicator(),
                // )

                Positioned(
                    bottom: 30,
                    left: MediaQuery.of(context).size.width * 0.8,
                    child: InkWell(
                      onTap: () {
                        showCupertinoModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            height: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CaptureImage(
                                                    event: widget.event,
                                                  )),
                                        );
                                      },
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.camera_alt,
                                              color: Colors.black45,
                                              size: 80,
                                            ),
                                            Text(
                                              "Camera",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black38),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final pickedImageFile =
                                        await ImagePickerHelper.pickImage(
                                            ImageSource.gallery);
                                    if (pickedImageFile != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => VerifyImage(
                                                pickedImageFile, widget.event)),
                                      );
                                    }
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.image,
                                        color: Colors.black45,
                                        size: 80,
                                      ),
                                      Text(
                                        "Choose from gallery",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black38),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera,
                            color: Colors.black45,
                            size: 50,
                          )),
                    ))
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
                        "Session",
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
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(
                          widget.event.name,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 20),
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
                      Text(
                        "Session Start Date : " + widget.event.startDate,
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Courses", style: subHeadingTextStyle),
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 10),
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: StreamBuilder<EventSession>(
                          stream: this.programStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<EventSession> snapshot) {
                            if (snapshot.hasData) {
                              return buildCourseCards(snapshot.data);
                            }
                            return Text("Loading....",
                                style: subHeadingTextStyle);
                          }))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
