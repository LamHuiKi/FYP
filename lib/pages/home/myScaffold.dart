import 'package:firebase1/shared/loading.dart';
import 'package:flutter/material.dart';
import 'myAppBar.dart';
import 'myFloatingActionButton.dart';
import 'tabView.dart';
import 'package:provider/provider.dart';
import 'package:firebase1/models/user.dart';

class MyScaffold extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    if(user != null){return DefaultTabController(
          length: user.isStaff? 3 : 2,
          child: Scaffold(
                  backgroundColor: Colors.white,
                  //drawer: Drawer(),
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(100.0),
                    child: MyAppBar()
                    ),
          //backgroundColor: Colors.grey,
          body: MyTabView(),/*TabBarView(children: [
            OngoingList(),
            AwaitList(),
            PreviousList(),
          ],),*/
          floatingActionButton: MyFloatingActionButton() ?? SizedBox(height: 0.1),/*FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderForm() ));},
              backgroundColor: Colors.purple,
          ),*/
        ),
    );}
    else return Loading();
  }
}