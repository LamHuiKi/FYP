class MyUserInfo{

  final String uid;

  MyUserInfo({this.uid});
}

class UserData{
  final String uid;
  final String valueA;
  final int valueB;
  final String phoneNumber;
  final String nickname;
  final bool isStaff;

  UserData({this.valueA, this.valueB, this.uid, this.phoneNumber, this.nickname, this.isStaff});
}