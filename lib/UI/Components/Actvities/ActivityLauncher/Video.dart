import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Video extends StatefulWidget {
  final String url;
  Video(this.url);
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  String errMsg = "";
  void _launchURL() async => await canLaunch(widget.url)
      ? await launch(widget.url)
      : errMsg = 'Could not launch $widget.url';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _launchURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(errMsg),
    ));
  }
}
