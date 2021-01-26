//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/models/orders.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
//import 'package:firebase1/models/orders.dart';
import 'package:firebase1/pages/home/orderTile.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {

    final orders = Provider.of<List<Orders>>(context) ?? [];

    /*for(var doc in orders.docs){
      print(doc.data());
    }*/
    orders.forEach((orders) {
      print(orders.valueA);
      print(orders.valueB);
     });
    //return Container();
    
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderTile(order: orders[index]);
      }
    );
  }
}