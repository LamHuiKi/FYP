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

  qrScan(context, bool isStaff, String uid)async{
  String result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>QRViewExample()) ) ?? "...";
  //print("orderTile isStaff: $isStaff");
  //print("fffffffff: ${user.uid}");
  
  await DatabaseService(lockerid: result).updateLockerDatabase('open', true);
  if(isStaff){

    DocumentSnapshot ref = await FirebaseFirestore.instance.collection('orders').doc(order.id).collection('Ongoing').doc(order.docId).get();
    String customerId = await DatabaseService().getUidByPhoneNumber(ref.data()['phoneNumber']);
    String timestamp = await ref.data()['timestamp'];
    await DatabaseService(uid: customerId).newDocumentInDatabase(order.docId, 'Ongoing', order.date, order.time, order.id, order.phoneNumber, order.food, result, order.restaurant, timestamp);
    await DatabaseService(uid: order.id).switchOrderType(order.docId, result, "Ongoing", "AwaitPickUp");
  }else{
    await DatabaseService(uid: order.id).switchOrderType(order.docId, result, "AwaitPickUp", "Previous");
    //print("customer after: ${order.docId}");
    await DatabaseService(uid: uid).switchOrderType(order.docId, result, "Ongoing", "Previous");
    
  }
  /*DocumentSnapshot ref = await FirebaseFirestore.instance.collection('orders').doc(order.id).collection('Ongoing').doc(order.docId).get();
   String customerId = await DatabaseService().getUidByPhoneNumber(ref.data()['phoneNumber']);
   await DatabaseService(uid: customerId).newDocumentInDatabase(null, 'Ongoing', order.date, order.time, order.id, order.phoneNumber, order.food, result);

   await DatabaseService(uid: order.id).switchOrderType(order.docId, result, "Ongoing", "AwaitPickUp");
   */
   
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    return Card(
      elevation: 3.0,
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
            Text(
              order.food,
            ),
            Text(
              "${order.date} ${order.time}",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        trailing: IconButton(icon: Icon(Icons.qr_code_scanner), onPressed: ()async{await qrScan(context, user.isStaff, user.uid);})
      ),
    );
  }
}
