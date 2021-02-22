import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase1/pages/home/orderList.dart';
import 'package:firebase1/models/orders.dart';
import 'package:firebase1/models/user.dart';

class DatabaseService{
  final String uid;
  final String lockerid; //test code
  DatabaseService({this.uid, this.lockerid}); //test

  final CollectionReference orderCollection = FirebaseFirestore.instance.collection('orders');
  final CollectionReference lockerCollection = FirebaseFirestore.instance.collection('test');//test code
  Future updateDatabase(String valueA, int valueB)async{
    return await orderCollection.doc(uid).set({
      'valueA': valueA,
      'valueB': valueB
    });
  }

  /*Future updateLockerDatabase(bool status, bool available, bool open)async{    //test
    return await lockerCollection.doc(lockerid).set({
      'lockerStatus': status,
      'available': available,
    });
  }*/

  Future updateLockerDatabase(String field, bool value)async{    //test
    return await lockerCollection.doc(lockerid).update({
      /*'lockerStatus': status,
      'available': available,*/
      field: value,
    });
  }
  
  List<Orders> _orderListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Orders(
        valueA: doc.data()['valueA'] ?? '',
        valueB: doc.data()['valueB'] ?? 0,
      );
    }).toList();
  }

  UserData _userDataFormSnapShot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      valueA: snapshot.data()['valueA'] ?? '',
      valueB: snapshot.data()['valueB'] ?? 0,
    );
  }

  Stream<List<Orders>> get orders{
    return orderCollection.snapshots().map(_orderListFromSnapshot);
  }

  Stream<UserData> get userData{
    return orderCollection.doc(uid).snapshots().map(_userDataFormSnapShot);
  }

  Stream<QuerySnapshot> get lockerInfo{
    return lockerCollection.snapshots();
  }

}