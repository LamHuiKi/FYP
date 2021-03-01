import 'package:flutter/foundation.dart';

class AwaitOrders extends ChangeNotifier {
  final String time;
  final String date;
  final String id;


  AwaitOrders({this.time, this.date, this.id});
}