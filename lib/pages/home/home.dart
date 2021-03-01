//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/models/orders.dart';
import 'package:firebase1/models/user.dart';
import 'package:firebase1/pages/home/orderList.dart';
import 'package:firebase1/pages/test/lockerInfo.dart';
import 'package:firebase1/services/auth.dart';
import 'package:firebase1/services/database.dart';
import 'package:firebase1/pages/home/settingsForm.dart';
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
  

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUserInfo>(context);
    void _showSettingsPanel(){
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

    return StreamProvider<List<AwaitOrders>>.value(
          value: DatabaseService(uid:user.uid).awaitOrders,
          child: StreamProvider<List<PreviousOrders>>.value(
            value: DatabaseService(uid:user.uid).previousOrders,
            child: StreamProvider<List<Orders>>.value(
              value: DatabaseService(uid: user.uid).orders,
              child: Scaffold(
                appBar: AppBar(
                //backgroundColor: Colors.blueGrey,
                title: Text('My Home'),
                actions: [
                  IconButton(
                    icon: Icon(Icons.chat_bubble_outline),
                    onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsForm() ));},
                  ),
                  FlatButton.icon(
                    onPressed: ()async{
                      await _auth.signOut();
                    },
                    icon: Icon(Icons.person),
                    label: Text('logout'),
                  ),
                  FlatButton.icon(
                    onPressed: _showSettingsPanel,
                    icon: Icon(Icons.settings),
                    label: Text('settings'),
                  ),
                  IconButton(
                    icon: Icon(Icons.text_fields),
                    onPressed: ()async{
                      print(FirebaseFirestore.instance.doc("orders/bEkhUfoYuqSMCiybDrEHigaRqso1/Ongoing/first").path);
                      await _getToken();
                    },
                  ),
                ],
              ),
            backgroundColor: Colors.grey,
            body: OrderList(),
          ),
        ),
      ),
    );
  }
}