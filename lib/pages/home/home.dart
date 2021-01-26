import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/models/orders.dart';
import 'package:firebase1/pages/home/orderList.dart';
import 'package:firebase1/pages/test/lockerInfo.dart';
import 'package:firebase1/services/auth.dart';
import 'package:firebase1/services/database.dart';
import 'package:firebase1/pages/home/settingsForm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:qr_code_scanner/qr_code_scanner.dart';


class HomePage extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
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

    return StreamProvider<List<Orders>>.value(
      value: DatabaseService().orders,
          child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: Text('My Home Page!'),
            actions: [
              IconButton(
                icon: Icon(Icons.chat_bubble_outline),
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> LockerInfo()));},
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
              )
            ],
          ),
        backgroundColor: Colors.grey,
        body: OrderList(),
      ),
    );
  }
}