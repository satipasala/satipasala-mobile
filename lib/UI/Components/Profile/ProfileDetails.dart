import 'package:flutter/material.dart';

class ProfileDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        new Container(
          width: 100.0,
          height: 100.0,
          decoration: new BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(height: 20),
        // new Text(
        //   'Dinuga Weeraratne | Student',
        //   style: TextStyle(color: Colors.white, fontSize: 20),
        // )
      ],
    );
  }
}
