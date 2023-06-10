import 'package:flutter/material.dart';
import 'SatiActivityCard.dart';
import '../../../../Firebase/model/Activity.dart';
import '../../../../Firebase/FirebaseDataSource.dart';
import '../../../../Firebase/CollectionService.dart';

class SatiActivityFeed extends StatefulWidget {
  @override
  _SatiActivityFeedState createState() => _SatiActivityFeedState();
}

class _SatiActivityFeedState extends State<SatiActivityFeed> {
  int _pageSize = 10;
  late FirebaseDataSource<Activity> _firebaseDataSource;
  @override
  void initState() {
    _firebaseDataSource = FirebaseDataSource<Activity>(
        _pageSize,
        CollectionService(
            "activities",
            (Map<String, dynamic> snapshot, [String? id]) =>
                Activity.fromSnapshot(snapshot, id)));
    _firebaseDataSource.nextBatch();
    super.initState();
  }


  Widget buildList(AsyncSnapshot<List<Activity>> snapshot) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        itemCount: snapshot.data?.length,
        itemBuilder: (BuildContext context, int index) {
          return SatiActivityCard(snapshot.data![index]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _firebaseDataSource.scrollController,
        child: Container(
          margin: EdgeInsets.all(5.0),
          height: 200,
          width: MediaQuery.of(context).size.width * 0.9,
          child:StreamBuilder<List<Activity>>(
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
        ));
  }
}
