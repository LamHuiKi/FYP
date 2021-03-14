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
  final CollectionReference phoneNumberCollection = FirebaseFirestore.instance.collection('phoneNumberToUid');

  CollectionReference getCollection(String uid, String path){
    print('this is: ');
    //print(uid);
    print(FirebaseFirestore.instance.collection('orders/$uid/$path').path);
    return FirebaseFirestore.instance.collection('orders/$uid/$path');
  }

  Future newDocumentInDatabase(String docName, String path, String date, String time, String id, String phoneNumber, String food, String lockerCell)async{
    if(docName == null){
      DocumentReference ref = getCollection(uid, path).doc();
      await ref.set({
      'date': date,
      'time': time,
      'id': id,
      'docId': ref.id,
      'phoneNumber': phoneNumber,
      'food': food,
      'lockerCell': lockerCell,
    });
    return ref;
    }
    else return await getCollection(uid, path).doc(docName).set({
      'date': date,
      'time': time,
      'id': id,
      'docId': docName,
      'phoneNumber': phoneNumber,
      'food': food,
      'lockerCell': lockerCell,
    });
  }
  
  Future updateDatabase(String nickname, String phoneNumber)async{
    await orderCollection.doc(uid).set({
      'nickname': nickname,
      'phoneNumber': phoneNumber,
    });
    await newDocumentInDatabase('Empty', 'Ongoing', null, null, null, null, null, null);
    await newDocumentInDatabase('Empty', 'AwaitPickUp', null, null, null, null, null, null);
    await newDocumentInDatabase('Empty', 'Previous', null, null, null, null, null, null);
  }

  Future switchOrderType(String docName, String before, String after)async{
    DocumentSnapshot docRef = await getCollection(uid, before).doc(docName).get();
    
    await newDocumentInDatabase(docName, after, docRef.data()['date'], docRef.data()['time'], docRef.data()['id'], docRef.data()['phoneNumber'], docRef.data()['food'], docRef.data()['lockerCell']);
    await getCollection(uid, before).doc(docName).delete();
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
        docId: doc.data()['docId'] ?? '',
        food: doc.data()['food'] ?? '',
        phoneNumber: doc.data()['phoneNumber'] ?? '',
      );
    }).toList();
  }

  List<Orders> _orderListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Orders(
        date: doc.data()['date'] ?? '',
        time: doc.data()['time'] ?? '',
        id: doc.data()['id'] ?? '',
        docId: doc.data()['docId'] ?? '',
        food: doc.data()['food'] ?? '',
        phoneNumber: doc.data()['phoneNumber'] ?? '',
      );
    }).toList();
  }

  List<AwaitOrders> _awaitListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return AwaitOrders(
        date: doc.data()['date'] ?? '',
        time: doc.data()['time'] ?? '',
        id: doc.data()['id'] ?? '',
        docId: doc.data()['docId'] ?? '',
        food: doc.data()['food'] ?? '',
        phoneNumber: doc.data()['phoneNumber'] ?? '',
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

  Future getUidByPhoneNumber(String phoneNumber)async{
    DocumentSnapshot ref = await phoneNumberCollection.doc(phoneNumber).get();
    print(ref.id);
    String result = await ref.data()['uid'];
    print("result: $result");
    return result;
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