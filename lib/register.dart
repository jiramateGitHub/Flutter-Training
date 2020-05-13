import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit

  // Method
  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.done),
      onPressed: () {
        print("click register");
      },
    );
  }

  Widget nameText() {
    return TextFormField(
      decoration: InputDecoration(
          icon: Icon(
            Icons.face,
            size: 48.0,
          ),
          labelText: 'Name',
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          helperText: 'Type Your Name for Display'),
    );
  }

  Widget emailText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          icon: Icon(
            Icons.email,
            size: 48.0,
          ),
          labelText: 'Email',
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          helperText: 'Type Your Email'),
    );
  }

  Widget passwordText() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            size: 48.0,
          ),
          labelText: 'Password',
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          helperText: 'Type Your Password more 6 Charactor'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        actions: <Widget>[registerButton()],
      ),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          nameText(),
          emailText(),
          passwordText(),
        ],
      ),
    );
  }
}
