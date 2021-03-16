import 'package:firebase1/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase1/models/user.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUserInfo _getDataFromFireBaseUser(User user){
    return user != null ? MyUserInfo(uid: user.uid) : null;
  }

  //user stream
  Stream <MyUserInfo> get user{
    return _auth.authStateChanges().map((User user) => _getDataFromFireBaseUser(user));
  }

  //anonymous
  Future signInAnon() async{
    try{
      UserCredential result =  await _auth.signInAnonymously();
      User user = result.user;
      return _getDataFromFireBaseUser(user);
    }catch(error){
      print('error: ${error.toString()}');
      return null;
    }
  }
  //signin-email-password
  Future signInWithEmail(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _getDataFromFireBaseUser(user);
    }catch(error){
      print('error: ${error.toString()}');
      return null;
    }
  }
  //register-email-password
  Future registerWithEmail(String email, String password, String nickName, String phoneNumber, bool isStaff) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      await DatabaseService(uid: user.uid).updateDatabase(nickName, phoneNumber, isStaff);//database init
      return _getDataFromFireBaseUser(user);
    }catch(error){
      print('error: ${error.toString()}');
      return null;
    }
  }
  //sign out
  Future signOut() async{
    try{
      return _auth.signOut();

    }catch(error){
      print(error.toString());
      return null;
    }
  }
}