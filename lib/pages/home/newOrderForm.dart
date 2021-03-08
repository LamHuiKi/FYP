import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase1/services/database.dart';
import 'package:provider/provider.dart';
import 'package:firebase1/models/user.dart';

class OrderForm extends StatefulWidget {
  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  String _phone;
  String _food;

  @override
  Widget build(BuildContext context) {
     final user = Provider.of<MyUserInfo>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Form'),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Form(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    onChanged: (val){
                      _phone = val;
                    },
                    decoration: InputDecoration(
                      labelText: 'phone no.'
                    ),
                  ),
                  TextField(
                    onChanged: (val){
                      _food = val;
                    },
                    textInputAction: TextInputAction.newline,
                    maxLines: 8,
                    minLines: 1,
                    decoration: InputDecoration(
                      labelText: 'food item'
                    ),
                  ),
                FlatButton(
                  child: Text('Order!!!!'),
                  onPressed: ()async{
                    await DatabaseService(uid: user.uid).newDocumentInDatabase(null, "Ongoing", DateTime.now().toString(), "time", user.uid, _phone, _food);
                  },
                  color: Colors.deepPurpleAccent,
                ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}