import 'package:flutter/material.dart';
import 'package:mobile/Firebase/CollectionService.dart';
import 'package:mobile/Firebase/FirebaseDataSource.dart';
import 'EventSession/EventSessionCard.dart';

import '../../Styles/AppStyles.dart';
import '../../../Firebase/model/EventSession.dart';
//import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class OngoingEventFeed extends StatefulWidget {
  @override
  _OngoingEventFeedState createState() => _OngoingEventFeedState();
}

class _OngoingEventFeedState extends State<OngoingEventFeed> {
  int _pageSize = 10;
  late FirebaseDataSource<EventSession> _firebaseDataSource;
  final List<String> imageList = [
    "https://i2.wp.com/www.satipasala.org/wp-content/uploads/2022/05/Sati-Pasala-Program-at-Anura-Central-College-Yakkala-7-1024x768.jpg?strip=info&w=1280&ssl=1",
    "https://i2.wp.com/www.satipasala.org/wp-content/uploads/2022/04/%E0%B7%83%E0%B6%AD%E0%B7%92-%E0%B6%B4%E0%B7%8F%E0%B7%83%E0%B6%BD-%E0%B6%9A%E0%B6%B3%E0%B7%80%E0%B7%94%E0%B6%BB-%E0%B7%80%E0%B6%BA%E0%B6%B9-%E0%B7%83%E0%B6%AD%E0%B7%92-%E0%B6%B4%E0%B7%8F%E0%B7%83%E0%B6%BD-%E0%B6%B8%E0%B6%B0%E0%B7%8A%E2%80%8D%E0%B6%BA%E0%B7%83%E0%B7%8A%E0%B6%AE%E0%B7%8F%E0%B6%B1%E0%B6%BA-45-1024x768.jpg?strip=info&w=2000&ssl=1",
    "https://i0.wp.com/www.satipasala.org/wp-content/uploads/2022/04/Sati-Pasala-Program-at-the-Drug-Addicts-Rehabilitation-Unit-Mampitiya-21-1024x768.jpg?strip=info&w=1040&ssl=1",
    "https://i0.wp.com/www.satipasala.org/wp-content/uploads/2022/04/Sati-Pasala-Program-at-the-Drug-Addicts-Rehabilitation-Unit-Mampitiya-21-1024x768.jpg?strip=info&w=1040&ssl=1"
  ];
  @override
  void initState() {
    _firebaseDataSource = FirebaseDataSource<EventSession>(
        _pageSize,
        CollectionService(
            "eventSessions",
            (Map<String, dynamic> snapshot, [String? id]) =>
                EventSession.fromSnapshot(snapshot, id)));
    _firebaseDataSource.nextBatch();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Previous Events",
              style: headerTextStyle,
            ),
            // InkWell(
            //     onTap: () async {},
            //     child: Text(
            //       "See All",
            //       style: TextStyle(color: Color(0xff7583CA), fontSize: 20),
            //     ))
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Container(
            margin: EdgeInsets.all(5.0),
            height: 180,
            width: MediaQuery.of(context).size.width * 0.9,
            child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                controller: _firebaseDataSource.scrollController,
                //children: [EventCard(), EventCard(), EventCard()],
                children: [
                  StreamBuilder<List<EventSession>>(
                      stream: _firebaseDataSource.connect(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return buildList(snapshot);
                        }
                      })
                ])),
      ],
    ));
  }

  Widget buildList(AsyncSnapshot<List<EventSession>> snapshot) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data?.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return EventSessionCard(snapshot.data![index]);
        });
  }
}
