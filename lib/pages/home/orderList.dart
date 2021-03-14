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

    orders.forEach((orders) {
      print(orders.date);
      print(orders.time);
     });
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
                      Text("Ongoing"),
                      if(OrderTile(order: snapshot.data[0][index]).order.docId != "Empty")OrderTile(order: snapshot.data[0][index]),
                    ],
                  );
                }
                if(index < orders.length)return OrderTile(order: snapshot.data[0][index]);
                if(index == orders.length) {
                  return Column(
                    children: [
                      Text("Await for pickup"),
                      if(AwaitTile(order: snapshot.data[1][index-orders.length]).order.docId != "Empty")AwaitTile(order: snapshot.data[1][index-orders.length])
                    ],
                  );
                }
                if(index < (orders.length + awaitOrders.length))return AwaitTile(order: snapshot.data[1][index-orders.length]);
                if(index == orders.length + awaitOrders.length){
                  return Column(
                    children: [
                      Text("Previous"),
                      if(PreviousTile(order: snapshot.data[2][index-orders.length-awaitOrders.length]).order.docId != "Empty")PreviousTile(order: snapshot.data[2][index-orders.length-awaitOrders.length]),
                    ],
                  );
                }
                if(index < (orders.length + previousOrders.length + awaitOrders.length))return PreviousTile(order: snapshot.data[2][index-orders.length-awaitOrders.length]);
              return null;
              }
            );
          }
          );
  }
}