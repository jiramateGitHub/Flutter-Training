import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  Authen({Key key}) : super(key: key);

  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Explicit

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[showAppName(), emailText(), passwordText()],
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
            labelStyle: TextStyle(color: Colors.red[700])),
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
            labelStyle: TextStyle(color: Colors.red[700])),
      ),
    );
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
          onPressed: () {}),
    );
  }
}
