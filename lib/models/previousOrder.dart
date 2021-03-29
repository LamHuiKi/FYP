import 'package:flutter/foundation.dart';

class PreviousOrders extends ChangeNotifier {
  final String time;
  final String date;
  final String id;
  final String docId;
  final String phoneNumber;
  final String food;
  final String restaurant;

  PreviousOrders({this.time, this.date, this.id, this.docId, this.phoneNumber, this.food, this.restaurant});
}