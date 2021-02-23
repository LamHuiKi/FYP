//import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Orders extends ChangeNotifier {
  final String time;
  final String date;
  final String id;


  Orders({this.time, this.date, this.id});
}
/*
import 'package:flutter/cupertino.dart';

class Orders with ChangeNotifier {
  final String valueA;
  final int valueB;

  Orders({this.valueA, this.valueB});
}*/