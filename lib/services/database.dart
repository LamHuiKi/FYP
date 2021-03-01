import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase1/pages/home/orderList.dart';
import 'package:firebase1/models/orders.dart';
import 'package:firebase1/models/user.dart';
import 'package:firebase1/models/previousOrder.dart';
import 'package:firebase1/models/AwaitOrder.dart';

class DatabaseService{
  final String uid; //= "bEkhUfoYuqSMCiybDrEHigaRqso1";
  final String lockerid; //test code
  DatabaseService({this.uid, this.lockerid}); //test

  final CollectionReference orderCollection = FirebaseFirestore.instance.collection('orders');
  //final CollectionReference orderCollection1 = FirebaseFirestore.instance.collection('orders/{uid}/Ongoing');
  //final CollectionReference orderCollection2 = FirebaseFirestore.instance.collection('orders/{uid}/Previous');
  //final CollectionReference orderCollection3 = FirebaseFirestore.instance.collection('orders/{uid}/AwaitPickUp');
  final CollectionReference lockerCollection = FirebaseFirestore.instance.collection('test');//test code
  
  CollectionReference getCollection(String uid, String path){
    print('this is: ');
    print(FirebaseFirestore.instance.collection('orders/$uid/$path').path);
    return FirebaseFirestore.instance.collection('orders/$uid/$path');
  }

  Future newDocumentInDatabase(String valueA, int valueB)async{
    return await getCollection(uid, "Ongoing").doc(uid).set({
      'valueA': valueA,
      'valueB': valueB,
    });
  }
  
  Future updateDatabase(String valueA, int valueB)async{
    return await getCollection(uid, "Ongoing").doc(uid).update({
      'valueA': valueA,
      'valueB': valueB,
    });
  }


  Future updateLockerDatabase(String field, bool value)async{    //test
    return await lockerCollection.doc(lockerid).update({
      field: value,
    });
  }
  
  List<PreviousOrders> _previousListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return PreviousOrders(
        date: doc.data()['date'] ?? '',
        time: doc.data()['time'] ?? '',
        id: doc.data()['id'] ?? '',
      );
    }).toList();
  }

  List<Orders> _orderListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Orders(
        date: doc.data()['date'] ?? '',
        time: doc.data()['time'] ?? '',
        id: doc.data()['id'] ?? '',
      );
    }).toList();
  }

  List<AwaitOrders> _awaitListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return AwaitOrders(
        date: doc.data()['date'] ?? '',
        time: doc.data()['time'] ?? '',
        id: doc.data()['id'] ?? '',
      );
    }).toList();
  }

  UserData _userDataFromSnapShot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      valueA: snapshot.data()['valueA'] ?? '',
      valueB: snapshot.data()['valueB'] ?? 0,
    );
  }

  Stream<List<Orders>> get orders{
    return getCollection(uid, "Ongoing").snapshots().map(_orderListFromSnapshot);
  }

  Stream<List<PreviousOrders>> get previousOrders{
    return getCollection(uid, "Previous").snapshots().map(_previousListFromSnapshot);
  }

  Stream<List<AwaitOrders>> get awaitOrders{
    return getCollection(uid, "AwaitPickUp").snapshots().map( _awaitListFromSnapshot);
  }

  Stream<UserData> get userData{
    return orderCollection.doc(uid).snapshots().map(_userDataFromSnapShot);
  }

  Stream<QuerySnapshot> get lockerInfo{
    return lockerCollection.snapshots();
  }

}