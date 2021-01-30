import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/services/database.dart';
import 'package:flutter/material.dart';

class LockerInfoTile extends StatelessWidget {
  final QueryDocumentSnapshot info;
  LockerInfoTile({this.info});
  @override
  Widget build(BuildContext context) {
    bool status = info.get('lockerStatus'); 
    String id = info.id;
    return Card(
      child: ListTile(
        title: Text(status.toString()),//info.get('lockerStatus').toString()),
        trailing: IconButton(
          icon: Icon(status? Icons.toggle_on: Icons.toggle_off),
          onPressed: ()async{DatabaseService(lockerid: id).updateLockerDatabase(!status, true);},
        ),
      ),
    );
  }
}