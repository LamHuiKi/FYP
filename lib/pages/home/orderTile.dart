import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase1/models/orders.dart';
import 'package:firebase1/services/qr.dart';
import 'package:firebase1/services/database.dart';
import 'package:provider/provider.dart';
import 'package:firebase1/models/user.dart';
class OrderTile extends StatelessWidget {
  
  final Orders order;
  OrderTile({this.order});
  qrScan(context)async{
   String result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>QRViewExample()) ) ?? "...";
   //print("result: $result");
   //await DatabaseService(lockerid: result).updateLockerDatabase('open', true);
   //print("fffffffff: ${user.uid}");
   DocumentSnapshot ref = await FirebaseFirestore.instance.collection('orders').doc(order.id).collection('Ongoing').doc(order.docId).get();
   String customerId = await DatabaseService().getUidByPhoneNumber(ref.data()['phoneNumber']);
   print("customerId: $customerId");
   await DatabaseService(uid: customerId).newDocumentInDatabase(null, 'Ongoing', order.date, order.time, order.id, order.phoneNumber, order.food);
   
   await DatabaseService(uid: order.id).switchOrderType(order.docId, "Ongoing", "AwaitPickUp");
   print("order.id: ${order.id}");
   
   //print("path: ${FirebaseFirestore.instance.collection('orders').doc(order.id).path}");

   
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          children: [
            Text(order.time),
            //IconButton(icon: Icon(Icons.change_history), onPressed: null)
            //Text(order.id),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(order.date),
            Text(order.id),
          ],
        ),
        trailing: IconButton(icon: Icon(Icons.qr_code_scanner), onPressed: (){qrScan(context);})
      ),
    );
  }
}
/*
import 'package:flutter/material.dart';
import 'package:firebase1/models/orders.dart';
import 'package:firebase1/services/qr.dart';
import 'package:firebase1/services/database.dart';
//import 'package:provider/provider.dart';

class OrderTile extends StatelessWidget {
  
  final Orders order;
  OrderTile({this.order});
  qrScan(context)async{
   String result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>QRViewExample()) ) ?? "...";
   //print("result: $result");
   await DatabaseService(lockerid: result).updateLockerDatabase('open', true);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          children: [
            Text(order.valueA),
            //IconButton(icon: Icon(Icons.change_history), onPressed: null)
          ],
        ),
        subtitle: Text((order.valueB).toString()),
        trailing: IconButton(icon: Icon(Icons.qr_code_scanner), onPressed: (){qrScan(context);})
      ),
    );
  }
}*/