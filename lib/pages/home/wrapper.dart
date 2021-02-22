import 'package:firebase1/pages/auth/auth.dart';
import 'package:firebase1/pages/home/home.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase1/models/user.dart';
import 'package:provider/provider.dart';
//import 'package:firebase1/services/pushNotification.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUserInfo>(context);
    //print(user);

    return user == null ? MyAuth() : HomePage();
  }
}