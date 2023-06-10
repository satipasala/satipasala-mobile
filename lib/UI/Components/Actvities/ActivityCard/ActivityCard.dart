import 'package:flutter/material.dart';
// import '../CourseDetails/CourseDetails.dart';
import '../../../../Firebase/model/Activity.dart';

class ActivityCard extends StatelessWidget {
  Activity _activity;
  ActivityCard(this._activity);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.2,
            child: InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => CourseDetails(
                //             courseInfo: _courseInfo,
                //           )),
                // );
              },
              child: Column(
                children: [
                  Image.asset(
                    'assets/courseimage.png',
                    fit: BoxFit.contain,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 0, top: 18, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            _activity.name,
                            style: const TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "3-10 MIN",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      Text(
                        " .SLEEP MUSIC",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
