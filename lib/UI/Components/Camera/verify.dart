import 'package:flutter/material.dart';
import 'dart:io';
import '../../../Actions/Event/UploadImage.dart';
import '../../../Firebase/model/EventSession.dart';

class VerifyImage extends StatefulWidget {
  final File image;
  final EventSession event;
  VerifyImage(this.image, this.event);
  @override
  _VerifyImageState createState() => _VerifyImageState();
}

class _VerifyImageState extends State<VerifyImage> {
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: Color(0xff03174C),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.99,
            child: Image.file(widget.image),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                          size: 80,
                        ),
                      ),
                      Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )
                    ]),
                    Column(children: [
                      InkWell(
                        onTap: () async {
                          await uploadImageAndSaveUrl(
                              "event_content", widget.event.id as String, widget.image);
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 80,
                        ),
                      ),
                      Text(
                        "Upload",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )
                    ]),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
