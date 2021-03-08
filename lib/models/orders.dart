//import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Orders extends ChangeNotifier {
  final String time;
  final String date;
  final String id;
  final String docId;
  final String phoneNumber;
  final String food;

  Orders({this.time, this.date, this.id, this.docId, this.phoneNumber, this.food});
}
/*
import 'package:flutter/cupertino.dart';

class Orders with ChangeNotifier {
  final String valueA;
  final int valueB;

  Orders({this.valueA, this.valueB});
}*/