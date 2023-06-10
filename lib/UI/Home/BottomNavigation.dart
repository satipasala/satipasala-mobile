import 'package:flutter/material.dart';
import '../Styles/AppStyles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Home.dart';
import '../Sati/Sati.dart';
import '../Courses/Courses.dart';
import '../Profile/Profile.dart';
import '../Actvities/Activities.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import '../Components/Actvities/ActivityLauncher/Meditate/dashboard.dart';
class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavyBar(
          mainAxisAlignment: MainAxisAlignment.center,
          backgroundColor: darkBackgroundColor,
          selectedIndex: _selectedIndex,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: [
            BottomNavyBarItem(
              textAlign: TextAlign.center,
              inactiveColor: Color(0xff98A1BD),
              icon: FaIcon(FontAwesomeIcons.home),
              title: Text('Home'),
              activeColor: Color(0xff8E97FD),
            ),
            BottomNavyBarItem(
                textAlign: TextAlign.center,
                inactiveColor: Color(0xff98A1BD),
                icon: FaIcon(FontAwesomeIcons.spa),
                title: Text('Sati'),
                activeColor: Color(0xff8E97FD)),
            BottomNavyBarItem(
                textAlign: TextAlign.center,
                inactiveColor: Color(0xff98A1BD),
                icon: FaIcon(FontAwesomeIcons.accusoft),
                title: Text('Activities'),
                activeColor: Color(0xff8E97FD)),
            BottomNavyBarItem(
                textAlign: TextAlign.center,
                inactiveColor: Color(0xff98A1BD),
                icon: FaIcon(FontAwesomeIcons.book),
                title: Text('Courses'),
                activeColor: Color(0xff8E97FD)),
            BottomNavyBarItem(
                textAlign: TextAlign.center,
                inactiveColor: Color(0xff98A1BD),
                icon: Icon(Icons.person),
                title: Text('Profile'),
                activeColor: Color(0xff8E97FD)),
          ],
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   showUnselectedLabels: true,
        //   elevation: 0,
        //   type: BottomNavigationBarType.fixed,
        //   backgroundColor: darkBackgroundColor,
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.home),
        //         label: 'Home',
        //         backgroundColor: darkBackgroundColor),
        //     BottomNavigationBarItem(
        //       icon: FaIcon(FontAwesomeIcons.spa),
        //       label: 'Sati',
        //     ),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.person),
        //         label: 'Profile',
        //         backgroundColor: darkBackgroundColor),
        //   ],
        //   currentIndex: _selectedIndex,
        //   selectedItemColor: Color(0xff8E97FD),
        //   unselectedItemColor: Color(0xff98A1BD),
        //   onTap: _onItemTapped,
        // ),
        backgroundColor: darkBackgroundColor,
        body: Center(
          child: <Widget>[
            Container(
              child: Home(),
            ),
            Container(
              child: MeditateDashbaord(),
            ),
            Container(
              child: Activities(),
            ),
            Container(
              child: Courses(),
            ),
            Container(child: Profile())
          ].elementAt(_selectedIndex),
        ));
  }
}
