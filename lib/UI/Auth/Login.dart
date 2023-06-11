import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:mobile/Firebase/AuthService.dart';

import '../Home/BottomNavigation.dart';
import 'Signup.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              clipBehavior: Clip.none,
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
                      decoration: const InputDecoration(
                          labelText: 'Enter your password',
                          filled: true,
                          fillColor: Color(0xffF2F3F7),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          )),
                    ))),
                Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.all(40.0),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Added this line
                      children: [
                        const Text("Welcome",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffE6E7F2))),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Container(
                            width: 200, // Added a specific width
                            height: 200, // Added a specific height
                            margin: const EdgeInsets.all(20.0),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Image.asset('assets/logo.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 110.0,
                    right: 50.0,
                    left: 50.0,
                    child: SizedBox(
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
                              .signIn(
                                  emailController.text, passwordController.text
                                  // 'sameeraroshanuom@gmail.com',
                                  // '123456'
                                  )
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
                        child: const Text(
                          "Login",
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
                        decoration: const BoxDecoration(
                          color: Color(0xffE6E7F2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
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
                        text: "Login With Google",
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
                            "Dont have an account? ",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          new InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignupScreen()));
                            },
                            child: new Padding(
                              padding: new EdgeInsets.all(10.0),
                              child: new Text(
                                'Sign Up Here',
                                style: TextStyle(
                                    color: Colors.blueAccent, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            )));
  }
}
