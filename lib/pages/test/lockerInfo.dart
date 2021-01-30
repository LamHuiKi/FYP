import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/pages/test/infoList.dart';
import 'package:firebase1/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LockerInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().lockerInfo,
        child: Scaffold(
          appBar: AppBar(
            title: Text('LockerInfo'),
            actions: [
              IconButton(
                icon: Icon(Icons.phone_android),
                onPressed: null
              )
            ],
          ),
        body: LockerInfoList(),
        ),
    );
  }
}
