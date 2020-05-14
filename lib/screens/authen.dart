import 'package:appshoppingmall/screens/my_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authen extends StatefulWidget {
  Authen({Key key}) : super(key: key);

  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String emailString, passwordString;

  // Method
  Widget backButton() {
    return IconButton(
      icon: Icon(
        Icons.navigate_before,
        size: 36.0,
        color: Colors.red[900],
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget content() {
    return Center(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[showAppName(), emailText(), passwordText()],
        ),
      ),
    );
  }

  Widget showAppName() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[showLogo(), showAppNameText()],
    );
  }

  Widget showLogo() {
    return Container(
      width: 48.0,
      height: 48.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showAppNameText() {
    return Text(
      "App Shopping Mall",
      style: TextStyle(
          fontSize: 30.0,
          color: Colors.red[900],
          fontWeight: FontWeight.bold,
          // fontStyle: FontStyle.italic,
          fontFamily: 'Indie Flower'),
    );
  }

  Widget emailText() {
    return Container(
      width: 250.0,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(
            Icons.email,
            size: 36.0,
            color: Colors.red[700],
          ),
          labelText: 'Email :',
          labelStyle: TextStyle(color: Colors.red[700]),
        ),
        onSaved: (String value) {
          emailString = value.trim();
        },
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please Fill Your Email in the Blank';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget passwordText() {
    return Container(
      width: 250.0,
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            size: 36.0,
            color: Colors.red[700],
          ),
          labelText: 'Password :',
          labelStyle: TextStyle(color: Colors.red[700]),
        ),
        onSaved: (String value) {
          passwordString = value.trim();
        },
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please Fill Your Password in the Blank';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Future<void> checkAuthen() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .signInWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((response) {
      print('Authen Success');
      MaterialPageRoute materialPageRoute = MaterialPageRoute(
        builder: (BuildContext context) => MyService(),
      );
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }).catchError((response){
      String title = response.code;
      String message = response.message;
      print('title = $title, message = $message');
      MyAlert(title,message);
    });
  }

   void MyAlert(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: ListTile(
              leading: Icon(
                Icons.add_alert,
                color: Colors.red,
                size: 48.0,
              ),
              title: Text(
                title,
                style: TextStyle(color: Colors.red),
              ),
            ),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            backButton(),
            content(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red[700],
          child: Icon(
            Icons.navigate_next,
          ),
          onPressed: () {
            formKey.currentState.save();
            formKey.currentState.validate();
            print('email : $emailString, password : $passwordString');
            checkAuthen();
          }),
    );
  }
}
