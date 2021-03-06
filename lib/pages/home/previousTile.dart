//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase1/models/previousOrder.dart';
import 'package:firebase1/services/qr.dart';
import 'package:firebase1/services/database.dart';
//import 'package:provider/provider.dart';

class PreviousTile extends StatelessWidget {
  
  final PreviousOrders order;
 PreviousTile({this.order});
  qrScan(context)async{
   String result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>QRViewExample()) ) ?? "...";
   //print("result: $result");
   await DatabaseService(lockerid: result).updateLockerDatabase('open', true);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: ListTile(
        title: Row(
          children: [
            Text(order.restaurant),
            //IconButton(icon: Icon(Icons.change_history), onPressed: null)
            //Text(order.id),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(order.food),
            Text("${order.date} ${order.time}"),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {},
        ),
      ),
    );
  }
}