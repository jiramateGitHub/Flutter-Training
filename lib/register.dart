import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String nameString, emailString, passwordString;

  // Method
  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.done),
      onPressed: () {
        print("click register");
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print('name $nameString');
        }
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
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please Fill Your Name in the Blank';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        nameString = value.trim();
      },
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
      validator: (String value) {
        if (!((value.contains('@')) && (value.contains('.')))) {
          return 'Please Type Email in Exp. you@email.com';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        emailString = value.trim();
      },
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
      validator: (String value) {
        if (value.length <= 6) {
          return 'Password More 6 Charactor';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        passwordString= value.trim();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        actions: <Widget>[registerButton()],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(30.0),
          children: <Widget>[
            nameText(),
            emailText(),
            passwordText(),
          ],
        ),
      ),
    );
  }
}
