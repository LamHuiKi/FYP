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
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
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
                    validator: (val) => val.isEmpty? 'Enter an email la' : null,
                    onChanged: (val){
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    validator: (val) => val.isEmpty? 'Enter a password la' : null,
                    onChanged: (val){
                      setState(() => password = val); },
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    child: Text('register'),
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        print('Email: $email');
                        print('Password: $password');
                        dynamic result = await _auth.registerWithEmail(email, password);
                        if(result == null){
                          setState(() => errorMessage = 'Please apply a valid email');
                        }
                      }
                    },
                  )
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