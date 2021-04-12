//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/models/orders.dart';
import 'package:firebase1/models/user.dart';
import 'package:firebase1/pages/home/awaitPickupList.dart';
import 'package:firebase1/pages/home/orderList.dart';
import 'package:firebase1/pages/home/previousList.dart';
import 'package:firebase1/services/auth.dart';
import 'package:firebase1/services/database.dart';
import 'package:firebase1/pages/home/settingsForm.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase1/models/previousOrder.dart';
import 'package:firebase1/models/AwaitOrder.dart';
import 'newOrderForm.dart';
import 'ongoingList.dart';
import 'awaitPickupList.dart';
import 'previousList.dart';
//gradient appbar
//import 'package:gradient_app_bar/gradient_app_bar.dart';
//import 'package:flutter_gradients/flutter_gradients.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class HomePage extends StatelessWidget {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _getToken()async{
    _firebaseMessaging.getToken().then((device){print('token: $device');});
  }
  final AuthService _auth = AuthService();
  

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
              child: DefaultTabController(
                length: 3,
                              child: Scaffold(
                backgroundColor: Colors.white,
                //drawer: Drawer(),
                appBar: NewGradientAppBar(
                title: Text('My Home'),
                gradient: const LinearGradient(colors: [Colors.purple, Colors.purpleAccent]),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.portrait,
                      //color: Colors.black,
                    ),
                    onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsForm() ));},
                  ),
                  
                  /*FlatButton.icon(
                    onPressed: _showSettingsPanel,
                    icon: Icon(Icons.settings),
                    label: Text('settings'),
                  ),*/
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: ()async{
                      await _getToken();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderForm() ));
                    },
                  ),
                  FlatButton.icon(
                    onPressed: ()async{
                      await _auth.signOut();
                    },
                    icon: Icon(Icons.logout),
                    label: Text('logout'),
                  ),
                ],
                bottom: TabBar(
                  labelColor: Colors.purple,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),),
                    color: Colors.purple[50],
                  ),
                  tabs: [
                    Tab(text: "Ongoing", iconMargin: EdgeInsets.only(bottom: 2.0),),
                    Tab(text: "Await Pickup", iconMargin: EdgeInsets.only(bottom: 2.0),),
                    Tab(text: "record", iconMargin: EdgeInsets.only(bottom: 2.0),),
                  ],
                  
                ),
            ),
        //backgroundColor: Colors.grey,
        body: TabBarView(children: [
          OngoingList(),
          AwaitList(),
          PreviousList(),
        ],),//OrderList(),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderForm() ));},
            backgroundColor: Colors.purple,
        ),
      ),
              ),
          ),
    ),
        ),
      );
  }
}