import 'package:flutter/material.dart';
import 'package:mobile/Firebase/CollectionService.dart';
import 'package:mobile/Firebase/FirebaseDataSource.dart';
import 'EventSession/EventSessionCard.dart';

import '../../Styles/AppStyles.dart';
import '../../../Firebase/model/EventSession.dart';

class OnlineEventFeed extends StatefulWidget {
  @override
  _OnlineEventFeedState createState() => _OnlineEventFeedState();
}

class _OnlineEventFeedState extends State<OnlineEventFeed> {
  int _pageSize = 10;
  late FirebaseDataSource<EventSession> _firebaseDataSource;

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
              "Online Events",
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
