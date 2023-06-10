import 'package:flutter/material.dart';
import '../Profile/BadgeFeed/BadgeFeed.dart';
import '../Profile/ProfileDetails.dart';
import '../Profile/ProfileMenu.dart';

class ProfileMenu extends StatefulWidget {
  @override
  _ProfileMenuState createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  int menuNumber = 0;

  List<Widget>? menus;
  Widget badgesPage = Column(
    children: [
      new Text(
        'Profile',
        style: TextStyle(color: Colors.white, fontSize: 30),
      )
    ],
  );

  Widget achievementsPage = Column(
    children: [
      new Text(
        'Badges',
        style: TextStyle(color: Colors.white, fontSize: 30),
      )
    ],
  );

  Widget editProfilePage = Column(
    children: [
      new Text(
        'Edit Profile',
        style: TextStyle(color: Colors.white, fontSize: 30),
      )
    ],
  );
  Widget profileHeading() {
    if (menuNumber == 0) {
      return badgesPage;
    } else if (menuNumber == 1) {
      return achievementsPage;
    } else if (menuNumber == 2) {
      return editProfilePage;
    }
    return badgesPage;
  }

  Widget feedType() {
    if (menuNumber == 0) {
      return BadgeFeed();
    } else if (menuNumber == 1) {
      return achievementsPage;
    } else if (menuNumber == 2) {
      return editProfilePage;
    }
    return BadgeFeed();
  }

  Widget menuBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              menuNumber = 0;
            });
          },
          child: new Container(
            width: 40.0,
            height: 40.0,
            decoration: new BoxDecoration(
              color: menuNumber == 0 ? Color(0xff8E97FD) : Color(0xffC4C4C4),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person, color: Colors.white),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              menuNumber = 1;
            });
          },
          child: new Container(
            width: 40.0,
            height: 40.0,
            decoration: new BoxDecoration(
              color: menuNumber == 1 ? Color(0xff8E97FD) : Color(0xffC4C4C4),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.games, color: Colors.white),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              menuNumber = 2;
            });
          },
          child: new Container(
            width: 40.0,
            height: 40.0,
            decoration: new BoxDecoration(
              color: menuNumber == 2 ? Color(0xff8E97FD) : Color(0xffC4C4C4),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.emoji_symbols, color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        profileHeading(),
        SizedBox(
          height: 20,
        ),
        ProfileDetails(),
        SizedBox(
          height: 20,
        ),
        menuBar(),
        // SizedBox(
        //   height: 20,
        // ),
        // BadgeFeed(),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
