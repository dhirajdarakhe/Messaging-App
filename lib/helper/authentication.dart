import 'package:flutter/material.dart';
import 'package:chat_app/views/signin.dart';
import 'package:chat_app/views/signup.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  bool isSignIn = true;

  void toggle() {
    setState(() {
      isSignIn = !isSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return isSignIn ? SignIn(toggle) : SignUp(toggle);
    if (isSignIn) {
      return SignIn(toggle);
    }else {
      return SignUp(toggle);
    }
  }
}
