import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

/*

class PushNotification extends StatelessWidget {

  final String serverToken = 'AAAA8cWJt68:APA91bFURA7zJEcvuqKlHJgkumyRRsWK1eGV2onEzwe5rCdLjx-XgWLqS2wwtIODsJ0IToSdE_lpJCa_-d7UX01rm6WEauqKJR0SHAa2VSaMxMW3TNGFCqpT7GJfEtaBu46omwBSSRou';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
_getToken()async{
    await firebaseMessaging.getToken().then((device){print('token: $device');});
  }
Future<Map<String, dynamic>> sendAndRetrieveMessage() async {

  await http.post(
    'https://fcm.googleapis.com/fcm/send',
     headers: <String, String>{
       'Content-Type': 'application/json',
       'Authorization': 'key=$serverToken',
     },
     body: jsonEncode(
     <String, dynamic>{
       'notification': <String, dynamic>{
         'body': 'this is a body',
         'title': 'this is a title'
       },
       'priority': 'high',
       'data': <String, dynamic>{
         'click_action': 'FLUTTER_NOTIFICATION_CLICK',
         'id': '1',
         'status': 'done'
       },
       'to': await firebaseMessaging.getToken(),
     },
    ),
  );

  

  final Completer<Map<String, dynamic>> completer =
     Completer<Map<String, dynamic>>();

  firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      completer.complete(message);
    },
  );

  return completer.future;

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: IconButton(
        icon: Icon(Icons.ac_unit),
        onPressed: ()async{await sendAndRetrieveMessage(); await _getToken();},
      )
    );
  }

}*/

class PushNotification extends StatefulWidget {

  @override
  _PushNotificationState createState() => _PushNotificationState();
}

class _PushNotificationState extends State<PushNotification> {
  final String serverToken = 'AAAA8cWJt68:APA91bFURA7zJEcvuqKlHJgkumyRRsWK1eGV2onEzwe5rCdLjx-XgWLqS2wwtIODsJ0IToSdE_lpJCa_-d7UX01rm6WEauqKJR0SHAa2VSaMxMW3TNGFCqpT7GJfEtaBu46omwBSSRou';

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

_getToken()async{
    await firebaseMessaging.getToken().then((device){print('token: $device');});
  }

Future<Map<String, dynamic>> sendAndRetrieveMessage() async {

  await http.post(
    'https://fcm.googleapis.com/fcm/send',
     headers: <String, String>{
       'Content-Type': 'application/json',
       'Authorization': 'key=$serverToken',
     },
     body: jsonEncode(
     <String, dynamic>{
       'notification': <String, dynamic>{
         'body': 'this is a body',
         'title': 'this is a title'
       },
       'priority': 'high',
       'data': <String, dynamic>{
         'click_action': 'FLUTTER_NOTIFICATION_CLICK',
         'id': '1',
         'status': 'done'
       },
       'to': await firebaseMessaging.getToken(),
     },
    ),
  );

  
  final Completer<Map<String, dynamic>> completer =
     Completer<Map<String, dynamic>>();

  firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      completer.complete(message);
      print('message!: $message');
    },
  );

  return completer.future;

}


@override
  void initState() {
    super.initState();
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      //onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: IconButton(
        icon: Icon(Icons.ac_unit),
        onPressed: ()async{await sendAndRetrieveMessage(); await _getToken();},
      )
    );
  }
}
