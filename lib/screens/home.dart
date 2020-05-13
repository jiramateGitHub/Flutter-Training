import 'package:appshoppingmall/register.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Method

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
      onPressed: () {},
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
