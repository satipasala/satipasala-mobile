import 'package:flutter/material.dart';
import 'package:mobile/UI/Components/Courses/CourseCard/CourseCard.dart';
import 'CourseCard.dart';
import '../../../../Firebase/model/Course.dart';
import '../../../../Firebase/FirebaseDataSource.dart';
import '../../../../Firebase/CollectionService.dart';

class SatiCourseFeed extends StatefulWidget {
  @override
  _SatiCourseFeedState createState() => _SatiCourseFeedState();
}

class _SatiCourseFeedState extends State<SatiCourseFeed> {
  int _pageSize = 2;
  late FirebaseDataSource<CourseInfo> _firebaseDataSource;
  @override
  void initState() {
    _firebaseDataSource = FirebaseDataSource<CourseInfo>(
        _pageSize,
        CollectionService(
            "courses",
            (Map<String, dynamic> snapshot, [String? id]) =>
                CourseInfo.fromSnapshot(snapshot, id)));
    _firebaseDataSource.nextBatch();
    super.initState();
  }

  Widget buildList(AsyncSnapshot<List<CourseInfo>> snapshot) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data?.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return CourseCard(snapshot.data![index]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          margin: EdgeInsets.all(5.0),
          height: 220,
          width: MediaQuery.of(context).size.width,
          child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              controller: _firebaseDataSource.scrollController,
              children: [
                StreamBuilder<List<CourseInfo>>(
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
              ]),
        ));
  }
}
