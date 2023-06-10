import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile/Firebase/AuthService.dart';
import 'package:mobile/UI/Components/Sati/ActivityFeed/PDFView.dart';
import 'package:mobile/UI/Components/Sati/YoutubePlayer/SatiYoutubePlayer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../Firebase/model/Activity.dart';
import '../../Actvities/ActivityLauncher/Meditate/dashboard.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class SatiActivityCard extends StatefulWidget {
  Activity activity;

  SatiActivityCard(this.activity);

  @override
  State<SatiActivityCard> createState() => _SatiActivityCardState();
}

class _SatiActivityCardState extends State<SatiActivityCard> {
  String errMsg = "";

  String remotePDFpath = "";


  Future<File> getFileFromUrl(String filename) async {
    String url = await FirebaseStorage.instance.ref(filename).getDownloadURL();
    var appDocDir = await getApplicationDocumentsDirectory();
    var filePath = '${appDocDir.path}/$filename.pdf';

    await Directory(appDocDir.path)
        .create(recursive: true); // ensure directory exists
    File file = File(filePath);
    // check if file already exists
    bool fileExists = await file.exists();
    // if file does not exist, download it, otherwise return the existing file
    if (!fileExists) {
      http.Response response = await http.get(Uri.parse(url));
      await file.writeAsBytes(response.bodyBytes);
    }

    return file;
  }

  void _launchURL(url) async => await canLaunch(url)
      ? await launch(url)
      : errMsg = 'Could not launch $url';

  @override
  Widget build(BuildContext context) {

    AuthService authService = context.read<AuthService>();
    return InkWell(
      onTap: () async {
        if (widget.activity.type?.contentType?['type'] != null) {
          var link = widget.activity.resource['link'];
          var name = widget.activity.name;
          var type = widget.activity.type?.contentType['type'];
          late Widget satiWidget;
          try {
            if (link != null) {
              if (type == "video") {
                satiWidget = SatiYoutubePlayer(link);
              } else if (type == "audio" || type == "video") {
                _launchURL(link);
              } else {
                if (type == "pdf") {
                  try {
                    await getFileFromUrl(link).then((f) {
                      setState(() {
                        remotePDFpath = f.path;
                      });
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new PDFScreen(
                                path: remotePDFpath,
                              )),
                    );
                  } catch (e) {}

                  // widget = PDFViewerCachedFromUrl(
                  //   url: link,
                  //   name: name,
                  // );
                  // widget = PDF(link, name);
                } else if (type == "meditate") {
                  satiWidget = MeditateDashbaord(
                    uid: "",
                  );
                } else {
                  throw ("Invalid Activity");
                }
              }
              if (satiWidget != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => satiWidget),
                );
              }
            }
          } catch (ex) {
            print(ex);
          }
        }
      },
      child: Container(
          width: 210,
          padding: const EdgeInsets.only(
            right: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      color: const Color(0xff84C6AE),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: FutureBuilder<String>(
                          future: authService
                              .getDefaultMediaPath(widget.activity.mediaFiles),
                          builder: (context, snapshot) {
                            if (snapshot.data != null &&
                                snapshot.data as String != "") {
                              return CachedNetworkImage(
                                imageUrl: snapshot.data as String,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              );
                            } else {
                              return Image.asset(
                                "assets/activity.jpeg",
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.4,
                                fit: BoxFit.cover,
                              );
                            }
                          },
                        ),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    widget.activity.name,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 5),
                      child: Text(widget.activity.type?.name as String,
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              fontStyle: FontStyle.italic)),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
