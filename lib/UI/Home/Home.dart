import 'package:flutter/material.dart';
import 'package:mobile/UI/Components/Actvities/RecommendedActivities/RecommendedActivityFeed.dart';
import 'package:mobile/UI/Components/Events/OngoingEventFeed.dart';
import '../Styles/AppStyles.dart';
import '../Components/Events/UpcomingEventFeed.dart';
import 'HomePages/home.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ScrollController _scrollController;
  ScrollController get scrollController => _scrollController;
  @override
  void initState() {
    super.initState();
    // List<OrderBy> orderby = [OrderBy("date", OrderByDirection.desc)];
    // _firebaseDataSource.setOrderBy(orderby);
    this._scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkBackgroundColor,
        body: SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //             Opacity(opacity: 0.9,
                //             child:  Container(
                //               padding: const EdgeInsets.all(15),
                //                 decoration: BoxDecoration(
                //                   color: Colors.white,
                // border: Border.all(
                //   color: Colors.blueGrey,
                // ),
                // borderRadius: BorderRadius.all(Radius.circular(20)),),
                //             // color: Colors.white,
                //             child: Padding(padding:const EdgeInsets.all(0),
                //                 child:Image.network("https://i0.wp.com/www.satipasala.org/wp-content/uploads/2017/06/Sati-Pasala-Logo.png?fit=768%2C246&ssl=1",
                //                     scale: 2,
                //                 ))

                //                 ),
                //            ),

                // HomePage(),
                SizedBox(
                  height: 25,
                ),
                OngoingEventFeed(),
                SizedBox(
                  height: 15,
                ),
                UpcomingEventFeed(),
                SizedBox(
                  height: 15,
                ),
                RecommendedActivityFeed(_scrollController),
                SizedBox(
                  height: 15,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Activity Feed",
                //       style: headerTextStyle,
                //     ),
                //     // InkWell(
                //     //     onTap: () async {},
                //     //     child: Text(
                //     //       "See All",
                //     //       style: TextStyle(color: Color(0xff7583CA), fontSize: 20),
                //     //     ))
                //   ],
                // ),
                // ActionFeed(this.scrollController)
                //  SizedBox(
                //     height: 15,
                //   ),
              ],
            ),
          ),
        ));
  }
}
