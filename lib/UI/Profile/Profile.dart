import 'package:flutter/material.dart';
import 'package:mobile/Firebase/AuthService.dart';
import '../Styles/AppStyles.dart';
import 'package:provider/provider.dart';
import '../Auth/Login.dart';
import '../Components/Profile/ProfileMenu.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: SingleChildScrollView(
          child: Column(
        children: [
          ProfileMenu(),
          Container(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff8E97FD),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              onPressed: () {
                context.read<AuthService>().signOut().then((value) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()));
                });
              },
              child: Text(
                "Sign Out",
                style: TextStyle(color: Color(0xffE6E7F2)),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
