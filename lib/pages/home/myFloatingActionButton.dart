import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase1/models/user.dart';
import 'newOrderForm.dart';
class MyFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    if (user.isStaff) {
      return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => OrderForm()));
        },
        backgroundColor: Colors.purple,
      );
    }else return SizedBox(height: 0);
  }
}
