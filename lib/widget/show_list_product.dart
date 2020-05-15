import 'package:appshoppingmall/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowListProduct extends StatefulWidget {
  @override
  _ShowListProductState createState() => _ShowListProductState();
}

class _ShowListProductState extends State<ShowListProduct> {
  // Field
  List<ProductModel> productModels = List();

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

        ProductModel productModel = ProductModel.fromMap(snapshot.data);
        setState(() {
          productModels.add(productModel);
        });
      }
    });
  }

  Widget showName(int index) {
    return Row(
      children: <Widget>[
        Text(
          productModels[index].name,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget showDetail(int index) {
    String str = productModels[index].detail;
    if (str.length > 100) {
      str = str.substring(0, 90);
      str = '$str ...';
    }
    return Text(
      str,
      style: TextStyle(
        fontSize: 14.0,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget showText(int index) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.width * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            showName(index),
            showDetail(index),
          ],
        ));
  }

  Widget showImage(int index) {
    return Container(
        padding: EdgeInsets.all(20.0),
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.width * 0.5,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage(productModels[index].path),
                fit: BoxFit.cover,
              )),
        ));
  }

  Widget showListView(int index) {
    return Row(
      children: <Widget>[showImage(index), showText(index)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: productModels.length,
        itemBuilder: (BuildContext buildContext, int index) {
          return showListView(index);
        },
      ),
    );
  }
}
