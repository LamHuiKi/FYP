import 'package:flutter/material.dart';
import 'ongoingList.dart';
import 'awaitPickupList.dart';
import 'previousList.dart';
import 'package:firebase1/models/user.dart';
import 'package:provider/provider.dart';


class MyTabView extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);

    return TabBarView(children: [
            OngoingList(),
            if(user.isStaff) AwaitList(),
            PreviousList(),
          ],
    );
  }
}