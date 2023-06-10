import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SatiYoutubePlayer extends StatefulWidget {
  String link;
  SatiYoutubePlayer(this.link):super();
  @override
  _SatiYoutubePlayerState createState() => _SatiYoutubePlayerState();
}

class _SatiYoutubePlayerState extends State<SatiYoutubePlayer> {
  late YoutubePlayerController _controller;

  @override
  Widget build(BuildContext context) {

    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.link) as String,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

   return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.indigo,
      progressColors: ProgressBarColors(
        playedColor: Colors.blue,
        handleColor: Colors.blueAccent,
      ),
      onReady: () {
        _controller.toggleFullScreenMode();
      },
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _controller.dispose();

    super.dispose();
  }

}
