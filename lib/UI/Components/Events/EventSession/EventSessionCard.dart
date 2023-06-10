import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../Styles/AppStyles.dart';
import 'EventSessionDetails.dart';
import '../../../../Firebase/AuthService.dart';
import 'package:intl/intl.dart';
import '../../../../Firebase/model/EventSession.dart';

class EventSessionCard extends StatefulWidget {
  final EventSession event;
  EventSessionCard(this.event);

  @override
  _EventSessionCardState createState() => _EventSessionCardState();
}

class _EventSessionCardState extends State<EventSessionCard> {
  int userCount = 0;
  final df = new DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    print(widget.event.name);
    // userCount = getEventSessionCount();
  }

  int getEventSessionCount() {
    List<MapEntry<dynamic, dynamic>> map =
        HashMap.from(widget.event.participation).entries.toList();
    return map.length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 25),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EventSessionDetails(widget.event)),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Stack(
                children: [
                  widget.event.imgUrls.length == 0
                      ? Image.asset(
                          "assets/event.jpeg",
                          height: 100.0,
                          width: 140.0,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          widget.event.imgUrls[0],
                          height: 100.0,
                          width: 140.0,
                          fit: BoxFit.cover,
                        ),
                  // widget.event.status['value'].toString().toLowerCase() ==
                  //         "started"
                  //     ? Positioned(
                  //         right: 6,
                  //         bottom: 6,
                  //         child: Icon(
                  //           Icons.circle,
                  //           color: Colors.green,
                  //           size: 15,
                  //         ))
                  //     : Container(),
                  Container(),
                  // Positioned(
                  //     top: 6,
                  //     left: 6,
                  //     child: Container(
                  //       padding: const EdgeInsets.all(7),
                  //       decoration: BoxDecoration(
                  //         color: Colors.amber,
                  //         shape: BoxShape.circle,
                  //       ),
                  //       child: Text(
                  //         "0",
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //     ))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: Colors.amber,
                ),
              ),
              Container(
                child: Text(
                  widget.event.startDate,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),

          SizedBox(
            height: 9,
          ),
          Container(
            width: 130,
            child: Text(
              widget.event.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: textColor, fontWeight: FontWeight.w400),
            ),
          ),

          //     ClipRRect(
          //   borderRadius: BorderRadius.circular(5.0),
          //   child: Stack(
          //     children: <Widget>[
          //       ColorFiltered(
          //         colorFilter: ColorFilter.mode(
          //             Colors.black.withOpacity(0.25), BlendMode.darken),
          //         child: Image.asset(
          //           "assets/medi02.jpeg",
          //           height: 100.0,
          //           width: 140.0,
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //       Positioned(
          //         child: Container(
          //           width: 130,
          //           child: Text(
          //             event.name,
          //             maxLines: 2,
          //             overflow: TextOverflow.ellipsis,
          //             style: TextStyle(
          //                 color: textColor, fontWeight: FontWeight.w700),
          //           ),
          //         ),
          //         top: 15,
          //       ),
          //     ],
          //   ),
          // ),
          // )
        ],
      ),
    );
  }
}
