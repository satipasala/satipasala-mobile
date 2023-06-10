import 'package:flutter/material.dart';
import '../BadgeCard.dart';

class BadgeFeed extends StatefulWidget {
  @override
  _BadgeFeedState createState() => _BadgeFeedState();
}

class _BadgeFeedState extends State<BadgeFeed> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [BadgeCard(), BadgeCard()],
      ),
    );
  }
}
