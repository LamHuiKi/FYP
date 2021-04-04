import 'package:flutter/material.dart';
import 'package:firebase1/services/database.dart';
import 'package:provider/provider.dart';
import 'package:firebase1/models/user.dart';
import 'package:intl/intl.dart';

class OrderForm extends StatefulWidget {
  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  String _phone;
  String _food;
  bool confirmOrder = false;
Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm your order'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Phone number: $_phone'),
              Text('Food: $_food'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Confirm'),
            onPressed: () {
              confirmOrder = true;
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              confirmOrder = false;
              Navigator.of(context).pop();
            },
          ),          
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
     final user = Provider.of<MyUserInfo>(context);
    //final user1 = Provider.of<UserData>(context);
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
                  child: Text('Order!!!'),
                  onPressed: ()async{
                    await _showMyDialog();
                    if(confirmOrder){
                      String nickName = await DatabaseService(uid: user.uid).getNickName();
                      await DatabaseService(uid: user.uid).newDocumentInDatabase(null, "Ongoing", DateFormat.yMd().format(DateTime.now()), DateFormat.jm().format(DateTime.now()), user.uid, _phone, _food, null, nickName, DateTime.now().toString());
                      Navigator.pop(context);
                    }
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