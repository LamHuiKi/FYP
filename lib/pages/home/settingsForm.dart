import 'package:firebase1/models/user.dart';
import 'package:firebase1/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase1/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<int> values = [0, 1, 2, 3];
  String _valueAInput;
  String _valueBInput;
  int _valueCInput;
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUserInfo>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Update the settings',
          style: TextStyle(fontSize: 15.0),
        ),
      ),
      body: StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){

            UserData userData = snapshot.data;
            return Form(
            key: _formKey,
            child: Column(
              children: [
                
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Nickname',
                  ),
                  textInputAction: TextInputAction.newline,
                  maxLines: 1,
                  //initialValue: _valueAInput ?? userData.valueA,
                  validator: (val) => val.isEmpty? 'Enter' : null,
                  onChanged: (val){
                    setState(() => _valueAInput = val);
                  },
                ),
                SizedBox(height:20.0),
                TextFormField(
                  decoration: InputDecoration(
                        hintText: 'your phone number',
                  ),
                  textInputAction: TextInputAction.newline,
                  maxLines: 1,
                  //initialValue: _valueAInput ?? userData.valueA,
                  validator: (val) => val.isEmpty? 'Enter' : null,
                  onChanged: (val){
                    setState(() => _valueBInput = val);
                  },
                ),
                /*DropdownButtonFormField(
                  value: _valueBInput ?? userData.valueB,
                  items: values.map((inputNumber) => DropdownMenuItem(value: inputNumber, child: Text('$inputNumber'))).toList(),
                  onChanged: (inputNumber) => setState(() => _valueBInput = inputNumber),
                ),*/
                SizedBox(height:20.0),
                Slider(
                  value: (_valueCInput ?? 400).toDouble(),
                  min: 100,
                  max: 900,
                  divisions: 8,
                  activeColor: Colors.amber[_valueCInput ?? 400],
                  inactiveColor: Colors.amber[_valueCInput ?? 400],
                  onChanged: (val) => setState(() => _valueCInput = val.round())
                ),
                SizedBox(height:20.0),
                RaisedButton(
                  onPressed: ()async{
                    print(_valueAInput);
                    print(_valueBInput);
                    print(_valueCInput);
                    await DatabaseService(uid: user.uid).updateDatabase(_valueAInput ?? userData.valueA, _valueBInput ?? userData.valueB, true);
                    Navigator.pop(context);
                  },
                  child: Text('Update'),
                ),
              ]
            ),
          );
          }else{
            return Loading();
          }
          
        }
      ),
    );
  }
}