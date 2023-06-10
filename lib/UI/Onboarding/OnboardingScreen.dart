import 'package:flutter/material.dart';
import '../Auth/Login.dart';
import '../Styles/AppStyles.dart';
import '../Home/BottomNavigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final firebaseUser = context.watch<User>();
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      return BottomNavigation();
    }

    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: darkBackgroundColor,
        padding: const EdgeInsets.only(
          top: 50,
          bottom: 50,
        ),
        child: Stack(
          children: [
            /*  Positioned(
              bottom: 50.0,
              right: 0.0,
              left: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  new Text(
                    "Dont have an account?",
                    style: TextStyle(color: Colors.white),
                  ),
                  new Text(
                    "Signup",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),*/
            Positioned(
                bottom: 100.0,
                right: 80.0,
                left: 80.0,
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff8E97FD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen())),
                    child: Text(
                      "Get Started",
                      style: TextStyle(color: Color(0xffE6E7F2)),
                    ),
                  ),
                )),
            Positioned(
                bottom: 200.0,
                right: 60.0,
                left: 60.0,
                child: Container(
                  child: Image.asset('assets/man_meditating.png'),
                )),
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      scale: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Sati Pasala",
                        style: TextStyle(
                            color: Color(0xffE6E7F2),
                            fontWeight: FontWeight.w400,
                            fontSize: 30),
                      ),
                    ),
                  ],
                )))
          ],
        ));
  }
}
