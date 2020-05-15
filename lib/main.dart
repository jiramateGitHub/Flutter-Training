import 'package:appshoppingmall/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Shopping Mall',
      theme: ThemeData(primarySwatch: Colors.red),
      home: Home(),
    );
  }
}
