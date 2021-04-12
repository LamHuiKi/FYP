//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/models/AwaitOrder.dart';
import 'package:firebase1/models/orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase1/pages/home/orderTile.dart';
import 'package:firebase1/models/previousOrder.dart';
import 'package:firebase1/pages/home/previousTile.dart';
import 'package:firebase1/pages/home/awaitTile.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase1/services/database.dart';
import 'package:firebase1/models/user.dart';

class AwaitList extends StatefulWidget {
  @override
  _AwaitListState createState() => _AwaitListState();
}

class _AwaitListState extends State<AwaitList> {


  @override
  Widget build(BuildContext context) {

    final awaitOrders = Provider.of<List<AwaitOrders>>(context) ?? [];

    final user = Provider.of<MyUserInfo>(context);
    final user1 = Provider.of<UserData>(context);

if(user1 == null)return SizedBox(height: 0);

    return StreamBuilder(
          stream: DatabaseService(uid: user.uid).awaitOrders,
          builder: (context, snapshot){
            return ListView.builder(
              itemCount: awaitOrders.length,
              itemBuilder: (context, index) {
                if(index == 0) {
                  return Column(
                    children: [
                      //Text("AwaitPickup"),
                      SizedBox(height: 20.0 ),
                      if(snapshot.data != null && snapshot.data[index].docId != "Empty")AwaitTile(order: snapshot.data[index]),
                    ],
                  );
                }
                if(snapshot.data != null && index < awaitOrders.length && index > 0 && snapshot.data[index].docId != "Empty")return AwaitTile(order: snapshot.data[index]);
              return SizedBox(height: 0);
              }
            );
          }
          );
  }
}