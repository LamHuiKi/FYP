import 'package:firebase1/models/orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase1/pages/home/orderTile.dart';
import 'package:firebase1/services/database.dart';
import 'package:firebase1/models/user.dart';
import 'package:firebase1/shared/loading.dart';

class OngoingList extends StatefulWidget {
  @override
  _OngoingListState createState() => _OngoingListState();
}

class _OngoingListState extends State<OngoingList> {


  @override
  Widget build(BuildContext context) {

    final orders = Provider.of<List<Orders>>(context) ?? [];

    final user = Provider.of<MyUserInfo>(context);
    final user1 = Provider.of<UserData>(context);

if(user1 == null)return Loading();

    return StreamBuilder(
          stream: DatabaseService(uid: user.uid).orders,
          builder: (context, snapshot){
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                if(orders.length == 1) return Center(heightFactor: 30, child: Text('No ongoing order at the moment'));
                if(index == 0) {
                  return Column(
                    children: [
                      //Text("Ongoing"),
                      SizedBox(height: 20.0 ),
                      if(snapshot.data != null && snapshot.data[index].docId != "Empty")OrderTile(order: snapshot.data[index]),
                    ],
                  );
                }
                if(snapshot.data != null && index < orders.length && index > 0 && snapshot.data[index].docId != "Empty")return OrderTile(order: snapshot.data[index]);
              return SizedBox(height: 0);
              }
            );
          }
          );
  }
}