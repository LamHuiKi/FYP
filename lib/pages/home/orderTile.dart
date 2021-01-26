//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase1/models/orders.dart';
import 'package:firebase1/services/qr.dart';
//import 'package:provider/provider.dart';

class OrderTile extends StatelessWidget {
  
  final Orders order;
  OrderTile({this.order});
  qrScan(context){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>QRViewExample()) );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          children: [
            Text(order.valueA),
            //Text(order.lockerStatus), //test code
            //Text(documents.data())
            IconButton(icon: Icon(Icons.change_history), onPressed: null)
          ],
        ),
        subtitle: Text((order.valueB).toString()),
        trailing: IconButton(icon: Icon(Icons.qr_code_scanner), onPressed: (){qrScan(context);})
      ),
    );
  }
}