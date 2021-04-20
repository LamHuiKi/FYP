//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/models/AwaitOrder.dart';
import 'package:firebase1/models/orders.dart';
import 'package:firebase1/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase1/pages/home/orderTile.dart';
import 'package:firebase1/models/previousOrder.dart';
import 'package:firebase1/pages/home/previousTile.dart';
import 'package:firebase1/pages/home/awaitTile.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase1/services/database.dart';
import 'package:firebase1/models/user.dart';

class PreviousList extends StatefulWidget {
  @override
  _PreviousListState createState() => _PreviousListState();
}

class _PreviousListState extends State<PreviousList> {


  @override
  Widget build(BuildContext context) {

    final previousOrders = Provider.of<List<PreviousOrders>>(context) ?? [];

    final user = Provider.of<MyUserInfo>(context);
    final user1 = Provider.of<UserData>(context);

if(user1 == null)return Loading();

    return StreamBuilder(
          stream: DatabaseService(uid: user.uid).previousOrders,
          builder: (context, snapshot){
            return ListView.builder(
              itemCount: previousOrders.length,
              itemBuilder: (context, index) {
                if(previousOrders.length == 1) return Center(heightFactor: 30, child: Text('No record at the moment'));
                if(index == 0) {
                  return Column(
                    children: [
                      //Text("Previous"),
                      SizedBox(height: 20.0 ),
                      if(snapshot.data != null && snapshot.data[index].docId != "Empty")PreviousTile(order: snapshot.data[index]),
                    ],
                  );
                }
                if(snapshot.data != null && index < previousOrders.length && index > 0 && snapshot.data[index].docId != "Empty")return PreviousTile(order: snapshot.data[index]);
              return SizedBox(height: 0);
              }
            );
          }
          );
  }
}