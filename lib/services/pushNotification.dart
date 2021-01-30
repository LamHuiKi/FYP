//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

/*class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future initialise() async {

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }
}*/

class FirebaseMessaging extends StatefulWidget {
  @override
  _FirebaseMessagingState createState() => _FirebaseMessagingState();
}

class _FirebaseMessagingState extends State<FirebaseMessaging> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}