import 'package:flutter/foundation.dart';

class AwaitOrders extends ChangeNotifier {
  final String time;
  final String date;
  final String id;
  final String docId;
  final String phoneNumber;
  final String food;

  final String lockerCell;
  final String restaurant;

  AwaitOrders({this.time, this.date, this.id, this.docId, this.phoneNumber, this.food, this.lockerCell, this.restaurant});
}