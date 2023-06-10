import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:mobile/Firebase/AuthService.dart';

import '../Home/BottomNavigation.dart';
import 'Login.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(0xff03174c),
            padding: const EdgeInsets.only(
              top: 30,
              bottom: 90,
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                    bottom: 260.0,
                    right: 50.0,
                    left: 50.0,
                    child: Container(
                        child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: 'Enter your email',
                          filled: true,
                          fillColor: Color(0xffF2F3F7),
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(8.0),
                            ),
                          )),
                    ))),
                Positioned(
                    bottom: 180.0,
                    right: 50.0,
                    left: 50.0,
                    child: Container(
                        child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: 'Enter your password',
                          filled: true,
                          fillColor: Color(0xffF2F3F7),
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(8.0),
                            ),
                          )),
                    ))),
                Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                      margin: EdgeInsets.all(40.0),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: Column(children: [
                        Container(
                            child: Text("Create an Account",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffE6E7F2)))),
                        if (MediaQuery.of(context).size.height * 0.3 > 240)
                          Container(
                              margin: EdgeInsets.all(20.0),
                              child: FittedBox(
                                  child: Image.asset('assets/logo.png'),
                                  fit: BoxFit.contain))
                      ])),
                ),
                Positioned(
                    bottom: 110.0,
                    right: 50.0,
                    left: 50.0,
                    child: Container(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff8E97FD),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        onPressed: () {
                          context
                              .read<AuthService>()
                              .signUp(
                                  emailController.text, passwordController.text)
                              .then((value) {
                            if (value != null) {
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          BottomNavigation()));
                            }
                          }).catchError((error) {
                            final snackBar = SnackBar(
                              content: Text(error),
                              action: SnackBarAction(
                                label: 'OK',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );

                            // Find the ScaffoldMessenger in the widget tree
                            // and use it to show a SnackBar.
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          });
                        },
                        child: Text(
                          "Signup",
                          style: TextStyle(color: Color(0xffE6E7F2)),
                        ),
                      ),
                    )),
                Positioned(
                  top: 30.0,
                  left: 20.0,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffE6E7F2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: Color(0xff3F414E),
                          size: 40,
                        )),
                  ),
                ),
                Positioned(
                    bottom: 30,
                    right: 50.0,
                    left: 50.0,
                    child: Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: SignInButton(
                        Buttons.Google,
                        mini: false,
                        text: "Signup With Google",
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        onPressed: () {
                          context
                              .read<AuthService>()
                              .signInWithGoogle()
                              .then((value) {
                            if (value != null) {
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          BottomNavigation()));
                            }
                          }).catchError((error) {
                            final snackBar = SnackBar(
                              content: Text(error),
                              action: SnackBarAction(
                                label: 'OK',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );

                            // Find the ScaffoldMessenger in the widget tree
                            // and use it to show a SnackBar.
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          });
                        },
                      ),
                    )),
                Positioned(
                    bottom: -40,
                    right: 50.0,
                    left: 50.0,
                    child: Container(
                      padding: const EdgeInsets.only(top: 30, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          new InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                            },
                            child: new Padding(
                              padding: new EdgeInsets.all(10.0),
                              child: new Text(
                                'Login Here',
                                style: TextStyle(
                                    color: Colors.blueAccent, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
              clipBehavior: Clip.none,
            )));
  }
}
