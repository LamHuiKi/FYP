import 'package:flutter/material.dart';
import 'package:firebase1/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String nickName = '';
  String phoneNumber = '';
  String errorMessage = '';
  bool isStaff = false;
  void toggleIsStaffButton(){
    setState((){isStaff = !isStaff;});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        //backgroundColor: Colors.blueGrey,
        title: Text('Sign Up'),
        actions: [
          FlatButton.icon(
            onPressed: (){
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text('Log in'),
          ),
        ],
      ),
      
      body: SingleChildScrollView(
              child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                    validator: (val) => val.isEmpty? 'Enter an email' : null,
                    onChanged: (val){
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                    obscureText: true,
                    validator: (val) => val.isEmpty? 'Enter a password' : null,
                    onChanged: (val){
                      setState(() => password = val); },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Nickname',
                      ),
                    obscureText: true,
                    validator: (val) => val.isEmpty? 'Enter a nickName' : null,
                    onChanged: (val){
                      setState(() => nickName = val); },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'phone Number',
                      ),
                    obscureText: true,
                    validator: (val) => val.isEmpty? 'Enter a phoneNumber' : null,
                    onChanged: (val){
                      setState(() => phoneNumber = val); },
                  ),
                  SizedBox(height: 20),
                  Row(
                  children:[
                    Text('Sign up as staff?'),
                    IconButton(
                      icon: Icon(isStaff? Icons.toggle_on : Icons.toggle_off),
                      onPressed: toggleIsStaffButton,
                    ),
                  ]
                  ),
                  RaisedButton(
                    child: Text('register'),
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        print('Email: $email');
                        print('Password: $password');
                        dynamic result = await _auth.registerWithEmail(email, password, nickName, phoneNumber, isStaff);
                        if(result == null){
                          setState(() => errorMessage = 'Please apply a valid email');
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: RaisedButton(
                child: Text('Anon sign in'),
                onPressed: () async{
                  dynamic result = await _auth.signInAnon();
                  if(result == null){
                    print('error sign in');
                  }
                  else
                  {
                    print('sign in successful');
                    print('UserID: ${result.uid}');
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Text(errorMessage,
              style: TextStyle(
                color: Colors.red,
                fontSize: 15,
              ),
            ),
          ],
        ),
      )
    );
  }
}