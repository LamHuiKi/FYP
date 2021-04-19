import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase1/services/auth.dart';
import 'package:firebase1/pages/home/settingsForm.dart';
import 'newOrderForm.dart';
import 'package:firebase1/models/user.dart';
import 'package:provider/provider.dart';
class MyAppBar extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  PreferredSizeWidget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    return NewGradientAppBar(
            title: user.isStaff ? Text('Staff') : Text('Customer'),
            gradient: const LinearGradient(colors: [Colors.purple, Colors.purpleAccent]),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.portrait,
                  //color: Colors.black,
                ),
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsForm() ));},
              ),
              
              /*FlatButton.icon(
                onPressed: _showSettingsPanel,
                icon: Icon(Icons.settings),
                label: Text('settings'),
              ),*/
              if(user.isStaff)
              IconButton(
                icon: Icon(Icons.add),
                onPressed: ()async{
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderForm() ));
                },
              ),
              FlatButton.icon(
                onPressed: ()async{
                  await _auth.signOut();
                },
                icon: Icon(Icons.logout),
                label: Text('logout'),
              ),
            ],
            bottom: TabBar(
              labelColor: Colors.purple,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),),
                color: Colors.purple[50],
              ),
              tabs: [
                Tab(text: "Ongoing", iconMargin: EdgeInsets.only(bottom: 2.0),),
                if(user.isStaff) Tab(text: "Await Pickup", iconMargin: EdgeInsets.only(bottom: 2.0),),
                Tab(text: "record", iconMargin: EdgeInsets.only(bottom: 2.0),),
              ],
              
            ),
        );
  }
}