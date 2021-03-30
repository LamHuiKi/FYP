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

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {


  @override
  Widget build(BuildContext context) {

    final orders = Provider.of<List<Orders>>(context) ?? [];
    final previousOrders = Provider.of<List<PreviousOrders>>(context) ?? [];
    final awaitOrders = Provider.of<List<AwaitOrders>>(context) ?? [];
    final user = Provider.of<MyUserInfo>(context);
    final user1 = Provider.of<UserData>(context);
   /* orders.forEach((orders) {
      print(orders.date);
      print(orders.time);
     });*/
    //return Container();
    /*return StreamBuilder(
          stream: CombineLatestStream.list([
            DatabaseService(uid: user.uid).orders,
            DatabaseService(uid: user.uid).previousOrders,
            DatabaseService(uid: user.uid).awaitOrders,
          ]),
          builder: (context, snapshot){
            return Column(
              children:[
                PreviousTile(order: snapshot.data[1][0]),
                OrderTile(order: snapshot.data[0][0]),
                OrderTile(order: snapshot.data[0][1]),
                AwaitTile(order: snapshot.data[2][0],)
              ],
            );  
          }
    );
  }
}
*/
if(user1 == null)return SizedBox(height: 0);
if(user1.isStaff == true){
       return StreamBuilder(
          stream: CombineLatestStream.list([
            DatabaseService(uid: user.uid).orders,
            DatabaseService(uid: user.uid).awaitOrders,
            DatabaseService(uid: user.uid).previousOrders,
          ]),
          builder: (context, snapshot){
            return ListView.builder(
              itemCount: orders.length + previousOrders.length + awaitOrders.length,
              itemBuilder: (context, index) {
                if(index == 0) {
                  return Column(
                    children: [
                      Text(
                        "Ongoing",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      if(snapshot.data != null && snapshot.data[0][index].docId != "Empty")
                      OrderTile(order: snapshot.data[0][index])
                    ],
                  );
                }
                if(snapshot.data != null && index < orders.length && index > 0 && snapshot.data[0][index].docId != "Empty")return OrderTile(order: snapshot.data[0][index]);
                if(index == orders.length) {
                  return Column(
                    children: [
                      Text(
                        "Await for pickup",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      if(snapshot.data != null && snapshot.data[1][index-orders.length].docId != "Empty")
                      AwaitTile(order: snapshot.data[1][index-orders.length])
                    ],
                  );
                }
                if(snapshot.data != null && index < (orders.length + awaitOrders.length) && index > orders.length && snapshot.data[1][index-orders.length].docId != "Empty")return AwaitTile(order: snapshot.data[1][index-orders.length]);
                if(index == orders.length + awaitOrders.length){
                  return Column(
                    children: [
                      Text(
                        "Previous",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      if(snapshot.data != null && snapshot.data[2][index-orders.length-awaitOrders.length].docId != "Empty")PreviousTile(order: snapshot.data[2][index-orders.length-awaitOrders.length]),
                    ],
                  );
                }
                if(snapshot.data != null && index < (orders.length + previousOrders.length + awaitOrders.length) && index > (orders.length + awaitOrders.length) && snapshot.data[2][index-orders.length-awaitOrders.length].docId != "Empty")return PreviousTile(order: snapshot.data[2][index-orders.length-awaitOrders.length]);
              return SizedBox(height: 0);
              }
            );
          }
          );
  }
  else{
    return StreamBuilder(
          stream: CombineLatestStream.list([
            DatabaseService(uid: user.uid).orders,
            DatabaseService(uid: user.uid).previousOrders,
          ]),
          builder: (context, snapshot){
            return ListView.builder(
              itemCount: orders.length + previousOrders.length,
              itemBuilder: (context, index) {
                if(index == 0) {
                  return Column(
                    children: [
                      Text("Ongoing"),
                      if(snapshot.data != null && snapshot.data[0][index].docId != "Empty")OrderTile(order: snapshot.data[0][index]),
                    ],
                  );
                }
                if(snapshot.data != null && index < orders.length && index > 0 && snapshot.data[0][index].docId != "Empty")return OrderTile(order: snapshot.data[0][index]);
                if(index == orders.length){
                  return Column(
                    children: [
                      Text("Previous"),
                      if(snapshot.data != null && snapshot.data[1][index-orders.length].docId != "Empty")PreviousTile(order: snapshot.data[1][index-orders.length]),
                    ],
                  );
                }
                if(snapshot.data != null && index < (orders.length + previousOrders.length) && index > orders.length && snapshot.data[1][index-orders.length].docId != "Empty")return PreviousTile(order: snapshot.data[1][index-orders.length]);
              return SizedBox(height: 0);
              }
            );
          }
          );
  }
}
}