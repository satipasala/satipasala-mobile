import 'package:flutter/material.dart';
import 'package:mobile/Firebase/CollectionService.dart';
import 'package:mobile/Firebase/FirebaseDataSource.dart';
import '../../../../Firebase/model/Action.dart';
import '../../User/UserActions/UserActionCard.dart';

class ActionFeed extends StatefulWidget {
  ScrollController scrollController;
  ActionFeed(this.scrollController,{required Key key}) : super(key: key);
  @override
  ActionFeedState createState() => ActionFeedState();
}

class ActionFeedState extends State<ActionFeed> {
  int _pageSize = 10;
  late FirebaseDataSource<UserAction> _firebaseDataSource;

  @override
  void initState() {
    // TODO: implement initState
    _firebaseDataSource = FirebaseDataSource<UserAction>(
        _pageSize,
        CollectionService(  "actionFeed",
            (Map<String, dynamic> snapshot, [String? id]) =>
                UserAction.fromSnapshot(snapshot, id)),widget.scrollController);


    // List<OrderBy> orderby = [OrderBy("date", OrderByDirection.desc)];
    // _firebaseDataSource.setOrderBy(orderby);
    _firebaseDataSource.nextBatch();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: ScrollPhysics(),
      child: ListView(shrinkWrap: true, physics: NeverScrollableScrollPhysics(),
          //children: [EventCard(), EventCard(), EventCard()],
          children: [
            StreamBuilder<List<UserAction>>(
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
          ],

      ),
    );
  }

  Widget buildList(AsyncSnapshot<List<UserAction>> snapshot) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: snapshot.data?.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return UserActionCard(snapshot.data![index]);
        });
  }
}
