import 'package:appshoppingmall/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  //Explicit
  String login = '...';

  //Method
  @override
  void initState() {
    super.initState();
    findDisplayName();
  }

  Widget showListProduct() {
    return ListTile(
      leading: Icon(Icons.list,size: 36.0,),
      title: Text('List Product'),
      subtitle: Text('Show all list product'),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget showAddProduct() {
    return ListTile(
      leading: Icon(Icons.playlist_add,size: 36.0,),
      title: Text('Add Product'),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  Future<void> findDisplayName() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    setState(() {
      login = firebaseUser.displayName;
    });
    print('login : $login');
  }

  Widget showDrawerHeaderLogin() {
    return Text(
      "Login By $login",
      style: TextStyle(
          fontSize: 14.0,
          color: Colors.red[900],
          fontWeight: FontWeight.bold,
          // fontStyle: FontStyle.italic,
          fontFamily: 'Indie Flower'),
    );
  }

  Widget showDrawerHeaderAppName() {
    return Text(
      "App Shopping Mall",
      style: TextStyle(
          fontSize: 18.0,
          color: Colors.red[900],
          fontWeight: FontWeight.bold,
          // fontStyle: FontStyle.italic,
          fontFamily: 'Indie Flower'),
    );
  }

  Widget showDrawerHeaderLogo() {
    return Container(
      width: 80.0,
      height: 80.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showDrawerHeader() {
    return DrawerHeader(
      child: Column(
        children: <Widget>[
          showDrawerHeaderLogo(),
          SizedBox(
            height: 4.0,
          ),
          showDrawerHeaderAppName(),
          showDrawerHeaderLogin(),
        ],
      ),
    );
  }

  Widget showDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[showDrawerHeader(), showListProduct(),showAddProduct()],
      ),
    );
  }

  Widget signOutButton() {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      tooltip: 'Sign Out',
      onPressed: () {
        MyAlert();
      },
    );
  }

  void MyAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are You Sure?'),
            content: Text('Do You Want Sign Out?'),
            actions: <Widget>[cancelButton(), okButton()],
          );
        });
  }

  Widget okButton() {
    return FlatButton(
      child: Text('Ok'),
      onPressed: () {
        Navigator.of(context).pop();
        processSignOut();
      },
    );
  }

  Widget cancelButton() {
    return FlatButton(
      child: Text('Cancel'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Future<void> processSignOut() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut().then((response) {
      MaterialPageRoute materialPageRoute = MaterialPageRoute(
        builder: (BuildContext context) => Home(),
      );
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
        actions: <Widget>[signOutButton()],
      ),
      body: Text('body'),
      drawer: showDrawer(),
    );
  }
}
