import 'package:flutter/material.dart';
import 'package:mobile/UI/Components/Sati/ActivityFeed/SatiActivityCard.dart';
import '../ActivityCard/ActivityCard.dart';
import '../../../../Firebase/model/Activity.dart';
import '../../../../Firebase/FirebaseDataSource.dart';
import '../../../../Firebase/CollectionService.dart';

class ActivtyFeed extends StatefulWidget {
  ScrollController scrollController;
  ActivtyFeed(this.scrollController) : super();
  @override
  _ActivtyFeedState createState() => _ActivtyFeedState();
}

class _ActivtyFeedState extends State<ActivtyFeed> {
  int _pageSize = 10;
  late FirebaseDataSource<Activity> _firebaseDataSource;
  @override
  void initState() {
    _firebaseDataSource = FirebaseDataSource<Activity>(
        _pageSize,
        CollectionService(
            "activities",
            (Map<String, dynamic> snapshot, [String? id]) =>
                Activity.fromSnapshot(snapshot, id)),
        this.widget.scrollController);
    _firebaseDataSource.nextBatch();
    super.initState();
  }

  Widget buildList(AsyncSnapshot<List<Activity>> snapshot) {
    List<Activity> newList = [];
    if (snapshot.data != null){
    for (int i = 0; i < snapshot.data!.length; i++) {
        var activity = snapshot.data![i];
        if (activity.type?.contentType != null && 
            (activity.type!.contentType['type'] == "pdf" || 
             activity.type!.contentType['type'] == "video")) {
            newList.add(activity);
        }
    }
  }
    

    return GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: newList.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          childAspectRatio: 0.8,
          crossAxisSpacing: 1,
          maxCrossAxisExtent: 300,
        ),
        itemBuilder: (BuildContext context, int index) {
          return SatiActivityCard(newList[index]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        child: StreamBuilder<List<Activity>>(
            stream: _firebaseDataSource.connect(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return buildList(snapshot);
              }
            }));
  }
}
