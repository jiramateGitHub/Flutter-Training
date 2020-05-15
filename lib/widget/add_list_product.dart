import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appshoppingmall/screens/my_service.dart';

class AddListProduct extends StatefulWidget {
  @override
  _AddListProductState createState() => _AddListProductState();
}

class _AddListProductState extends State<AddListProduct> {
  //Field
  File file;
  String name, detail, urlPicture;

  //Method

  Future<void> showAlert(String title, String message) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            )
          ],
        );
      },
    );
  }

  Widget uploadButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: RaisedButton.icon(
            color: Colors.red,
            onPressed: () {
              if (file == null) {
                showAlert('Non Choose Picture', 'Please Choose Picture');
              } else if (name == '' || detail == null) {
                showAlert('Have Space', 'Please fill every Blank');
              } else if (detail == '' || detail == null) {
                showAlert('Have Space', 'Please fill every Blank');
              } else {
                uploadPictureToStore();
              }
            },
            icon: Icon(
              Icons.cloud_upload,
              color: Colors.white,
            ),
            label: Text('Upload'),
            textColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Future<void> uploadPictureToStore() async {
    Random random = Random();
    int i = random.nextInt(10000);

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    StorageReference storageReference =
        firebaseStorage.ref().child('Product/product$i.jpg');
    StorageUploadTask storageUploadTask = storageReference.putFile(file);

    urlPicture =
        await (await storageUploadTask.onComplete).ref.getDownloadURL();
    print("urlPicture : $urlPicture");
    insertValueToFireStore();
  }

  Future<void> insertValueToFireStore() async {
    Firestore firestore = Firestore.instance;

    Map<String, dynamic> map = Map();
    map['name'] = name;
    map['detail'] = detail;
    map['path'] = urlPicture;

    await firestore.collection('Product').document().setData(map).then((value) {
      print('Insert Success');
      MaterialPageRoute materialPageRoute = MaterialPageRoute(
        builder: (BuildContext context) => MyService(),
      );
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    });
  }

  Widget nameForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: TextField(
        onChanged: (String string) {
          name = string.trim();
        },
        decoration: InputDecoration(
          labelText: 'Name Product',
          helperText: 'Type Your Name of Product',
          icon: Icon(Icons.face),
        ),
      ),
    );
  }

  Widget detailForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: TextField(
        onChanged: (String string) {
          detail = string.trim();
        },
        decoration: InputDecoration(
          labelText: 'Detail',
          helperText: 'Type Your Detail of Product',
          icon: Icon(Icons.details),
        ),
      ),
    );
  }

  Future<void> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker.pickImage(
        source: imageSource,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );

      setState(() {
        file = object;
      });
    } catch (e) {}
  }

  Widget galleryButton() {
    return IconButton(
      icon: Icon(
        Icons.add_photo_alternate,
        size: 36.0,
      ),
      onPressed: () {
        chooseImage(ImageSource.gallery);
      },
    );
  }

  Widget cameraButton() {
    return IconButton(
      icon: Icon(
        Icons.add_a_photo,
        size: 36.0,
      ),
      onPressed: () {
        chooseImage(ImageSource.camera);
      },
    );
  }

  Widget showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        cameraButton(),
        galleryButton(),
      ],
    );
  }

  Widget showImage() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: file == null
          ? Image.asset('images/iconfinder_image.png')
          : Image.file(file),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
    );
  }

  Widget showContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          showImage(),
          showButton(),
          nameForm(),
          detailForm(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          showContent(),
          uploadButton(),
        ],
      ),
    );
  }
}
