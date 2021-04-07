import 'package:flutter/material.dart';
import 'package:firebase1/services/database.dart';
import 'package:provider/provider.dart';
import 'package:firebase1/models/user.dart';
import 'package:intl/intl.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

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
      appBar: NewGradientAppBar(
        gradient: LinearGradient(colors: [Colors.purple, Colors.red]),
        title: Text('New Order'),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text(
                  "${DateFormat.yMMMMEEEEd().format(DateTime.now())}, ${DateFormat.jm().format(DateTime.now())}")),
          Form(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 16.0),
              child: Column(
                children: [
                  TextField(
                    onChanged: (val) {
                      _phone = val;
                    },
                    decoration: InputDecoration(
                        icon: Icon(Icons.phone_android),
                        labelText: 'Customer phone no.'),
                  ),
                  TextField(
                    onChanged: (val) {
                      _food = val;
                    },
                    textInputAction: TextInputAction.newline,
                    maxLines: 8,
                    minLines: 1,
                    decoration: InputDecoration(
                        icon: Icon(Icons.fastfood), labelText: 'food item'),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        color: Colors.lightGreen[50],
                        //textColor: Colors.blue,
                        child: Text('Confirm'),
                        onPressed: () async {
                          await _showMyDialog();

                          if (confirmOrder) {
                            String nickName =
                                await DatabaseService(uid: user.uid)
                                    .getNickName();
                            await DatabaseService(uid: user.uid)
                                .newDocumentInDatabase(
                                    null,
                                    "Ongoing",
                                    DateFormat.yMd().format(DateTime.now()),
                                    DateFormat.jm().format(DateTime.now()),
                                    user.uid,
                                    _phone,
                                    _food,
                                    null,
                                    nickName,
                                    DateTime.now().toString());
                            Navigator.pop(context);
                          }
                        },
                        //color: Colors.deepPurpleAccent,
                      ),
                      /*FlatButton(
                        textColor: Colors.red,
                        child: Text('Cancel'),
                        onPressed: () async {
                            Navigator.pop(context);
                          }
                      ),*/
                    ],
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
