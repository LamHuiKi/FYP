import 'package:firebase1/models/orders.dart';
import 'package:firebase1/models/user.dart';
import 'package:firebase1/pages/home/myScaffold.dart';
import 'package:firebase1/services/auth.dart';
import 'package:firebase1/services/database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase1/models/previousOrder.dart';
import 'package:firebase1/models/AwaitOrder.dart';


class HomePage extends StatelessWidget {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _getToken()async{
    _firebaseMessaging.getToken().then((device){print('token: $device');});
  }
  final AuthService _auth = AuthService();
  static const routeName = '/homeRoute';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUserInfo>(context);
/*    void _showSettingsPanel(){
      showModalBottomSheet(
        context: context,
        builder: (context){
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: SettingsForm(),
          );
        }
      );
    }
*/
    return StreamProvider<List<AwaitOrders>>.value(
      value: DatabaseService(uid:user.uid).awaitOrders,
      child: StreamProvider<List<PreviousOrders>>.value(
        value: DatabaseService(uid:user.uid).previousOrders,
        child: StreamProvider<List<Orders>>.value(
          value: DatabaseService(uid: user.uid).orders,
          child: StreamProvider<UserData>.value(
            value: DatabaseService(uid: user.uid).userData,
            child: MyScaffold(),
                ),
              ),
            ),
         );
  }
}