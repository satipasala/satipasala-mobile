import 'package:flutter/material.dart';

import '../../../../Firebase/CollectionService.dart';
import '../../../../Firebase/FirebaseDataSource.dart';
import '../../../../Firebase/model/Course.dart';
import '../CourseCard/CourseCard.dart';

class CourseFeed extends StatefulWidget {
  ScrollController scrollController;

  CourseFeed(this.scrollController) : super();

  @override
  _CourseFeedState createState() => _CourseFeedState();
}

class _CourseFeedState extends State<CourseFeed> {
  int _pageSize = 10;
  late FirebaseDataSource<CourseInfo> _firebaseDataSource;

  @override
  void initState() {
    _firebaseDataSource = FirebaseDataSource<CourseInfo>(
        _pageSize,
        CollectionService(
            "courses",
            (Map<String, dynamic> snapshot, [String? id]) =>
                CourseInfo.fromSnapshot(snapshot, id)),
        this.widget.scrollController);
    _firebaseDataSource.nextBatch();
    
    super.initState();
  }

  Widget buildList(AsyncSnapshot<List<CourseInfo>> snapshot) {
    return GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: snapshot.data?.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          childAspectRatio: 1.1,
          crossAxisSpacing: 0,
          maxCrossAxisExtent: 300,
        ),
        itemBuilder: (BuildContext context, int index) {
          return CourseCard(snapshot.data![index]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: StreamBuilder<List<CourseInfo>>(
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
