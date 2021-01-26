import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/pages/test/lockerInfoTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LockerInfoList extends StatefulWidget {
  @override
  _LockerInfoListState createState() => _LockerInfoListState();
}

class _LockerInfoListState extends State<LockerInfoList> {
  @override
  Widget build(BuildContext context) {
    final infos = Provider.of<QuerySnapshot>(context)?.docs;
    
    return ListView.builder(
      itemCount: infos?.length?? 0,
      itemBuilder: (context, index){
        return LockerInfoTile(info: infos[index]);
      }
    );
  }
}