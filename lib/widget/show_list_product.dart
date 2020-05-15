import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowListProduct extends StatefulWidget {
  @override
  _ShowListProductState createState() => _ShowListProductState();
}

class _ShowListProductState extends State<ShowListProduct> {
  // Field

  // Method
  @override
  void initState() {
    super.initState();
    readAllData();
  }

  Future<void> readAllData() async {
    Firestore firestore = Firestore.instance;
    CollectionReference collectionReference = firestore.collection('Product');
    print('readAllData');
    await collectionReference.snapshots().listen((response) {
      print('collectionReference');
      List<DocumentSnapshot> snapshots = response.documents;
      for (var snapshot in snapshots) {
        print('snapshot = $snapshot');
        print('snapshot = ${snapshot.data['name']}');

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('This is ShowListProuct'),
    );
  }
}
