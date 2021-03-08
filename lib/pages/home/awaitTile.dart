import 'package:firebase1/services/qr.dart';
import 'package:firebase1/services/database.dart';
import 'package:firebase1/models/AwaitOrder.dart';
import 'package:flutter/material.dart';

//import 'package:provider/provider.dart';

class AwaitTile extends StatelessWidget {
  
  final AwaitOrders order;
 AwaitTile({this.order});
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
            Text(order.time),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(order.date),
            Text(order.id),
          ],
        ),
        trailing: Text(
          "Pending User Retrival",
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}