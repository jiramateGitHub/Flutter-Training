import 'package:appshoppingmall/screens/authen.dart';
import 'package:appshoppingmall/screens/my_service.dart';
import 'package:appshoppingmall/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Method

  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  Future<void> checkStatus() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    if (firebaseUser != null) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }
  }

  Widget showLogo() {
    return Container(
      width: 120.0,
      height: 120.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showAppName() {
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

  Widget signInButton() {
    return RaisedButton(
      color: Colors.blue.shade700,
      child: Text(
        'sign in',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () {
        MaterialPageRoute materialPageRoute = MaterialPageRoute(
          builder: (BuildContext context) => Authen(),
        );
        Navigator.of(context).push(materialPageRoute);
      },
    );
  }

  Widget signUpButton() {
    return OutlineButton(
      child: Text(
        'sign up',
        style: TextStyle(
          color: Colors.red[900],
        ),
      ),
      onPressed: () {
        MaterialPageRoute materialPageRoute = MaterialPageRoute(
          builder: (BuildContext context) => Register(),
        );
        Navigator.of(context).push(materialPageRoute);
      },
    );
  }

  Widget showButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        signInButton(),
        SizedBox(
          width: 2.0,
        ),
        signUpButton()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              showLogo(),
              SizedBox(
                height: 8.0,
              ),
              showAppName(),
              SizedBox(
                height: 8.0,
              ),
              showButton(),
            ],
          ),
        ),
      ),
    );
  }
}
