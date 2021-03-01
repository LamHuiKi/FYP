import 'package:flutter/foundation.dart';

class PreviousOrders extends ChangeNotifier {
  final String time;
  final String date;
  final String id;


  PreviousOrders({this.time, this.date, this.id});
}