import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../Firebase/AuthService.dart';
import '../CourseDetails/CourseDetails.dart';
import '../../../../Firebase/model/Course.dart';
import 'package:provider/provider.dart';

class CourseCard extends StatelessWidget {
  CourseInfo _courseInfo;
  CourseCard(this._courseInfo);
  @override
  Widget build(BuildContext context) {
    AuthService authService = context.read<AuthService>();
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CourseDetails(
                                courseInfo: _courseInfo,
                              )),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child:FutureBuilder<String>(
                            future: authService.getDefaultMediaPath(_courseInfo.mediaFiles),
                            builder: (context, snapshot) =>
                            snapshot.data != null
                                ? CachedNetworkImage(
                              imageUrl: snapshot.data as String,
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            )
                                : Image.asset( 'assets/AdobeStock_224390624.jpeg', fit: BoxFit.contain))
                       ,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 0, top: 10, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                _courseInfo.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
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
                            "Course",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
