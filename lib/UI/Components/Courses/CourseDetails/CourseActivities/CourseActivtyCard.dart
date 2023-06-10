import 'package:flutter/material.dart';
import '../../../SoundPlayer/SoundPlayer.dart';

class CourseActivityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          top: 20,
        ),
        child: Row(
          children: [
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SoundPlayer()),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 40,
                    )),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              "What is mindfullness ?",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
