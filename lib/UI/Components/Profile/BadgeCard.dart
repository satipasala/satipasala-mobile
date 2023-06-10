import 'package:flutter/material.dart';
import 'LevelBar.dart';

class BadgeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 16),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            color: Color(0xff2B3166),
            width: MediaQuery.of(context).size.width * 0.9,
            height: 100,
            child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/badge.png'),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: Text(
                              'Meditator',
                              style: TextStyle(
                                  color: Color(0xffE6E7F2), fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 6.0, top: 6, bottom: 6),
                            child: Text(
                              'Level 2',
                              style: TextStyle(
                                  color: Color(0xffE6E7F2), fontSize: 10),
                            ),
                          ),
                          LevelBar()
                        ],
                      ),
                    )
                  ],
                )),
          )),
    );
  }
}
