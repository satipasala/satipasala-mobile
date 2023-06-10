import 'package:flutter/material.dart';
import 'package:mobile/UI/Components/Actvities/ActivityCard/ActivityCard.dart';
import 'package:mobile/UI/Components/Sati/ActivityFeed/SatiActivityCard.dart';
import 'package:mobile/UI/Styles/AppStyles.dart';
import '../../../../Firebase/model/Activity.dart';
import '../../../../Firebase/FirebaseDataSource.dart';
import '../../../../Firebase/CollectionService.dart';
import 'package:mobile/Firebase/CollectionService.dart';
import 'package:mobile/Firebase/FirebaseDataSource.dart';

class RecommendedActivityFeed extends StatefulWidget {
  ScrollController scrollController;
  RecommendedActivityFeed(this.scrollController) : super();
  @override
  State<RecommendedActivityFeed> createState() => _RecommendedActivityFeed();
}

class _RecommendedActivityFeed extends State<RecommendedActivityFeed> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Popular Activities",
              style: headerTextStyle,
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Container(
            margin: EdgeInsets.only(top: 5, left: 0, right: 2),
            height: 230,
            width: MediaQuery.of(context).size.width * 0.9,
            child: ListView(scrollDirection: Axis.horizontal, shrinkWrap: true,
                // controller: _firebaseDataSource.scrollController,

                children: [
                  StreamBuilder<List<Activity>>(
                      stream: _firebaseDataSource.connect(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
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

  Widget buildList(AsyncSnapshot<List<Activity>> snapshot) {
    List<Activity> newList = [];

    for (var i = 0; i < snapshot.data!.length; i++) {
      if (snapshot.data?[i].type?.contentType?['type'] == "pdf" ||
          snapshot.data?[i].type?.contentType?['type'] == "video") {
        newList.add(snapshot.data![i]);
      }
    }
    return ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: newList.length,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 3);
        },
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return SatiActivityCard(newList[index]);
        });
  }
}
