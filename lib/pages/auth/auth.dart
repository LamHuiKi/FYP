import 'package:firebase1/pages/auth/signIn.dart';
import 'package:firebase1/pages/auth/register.dart';
import 'package:flutter/material.dart';

class MyAuth extends StatefulWidget {
  @override
  _MyAuthState createState() => _MyAuthState();
}

class _MyAuthState extends State<MyAuth> {
  bool showSignIn = true;
  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showSignIn ? SignIn(toggleView: toggleView) : Register(toggleView: toggleView),
    );
  }
}