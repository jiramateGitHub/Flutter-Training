import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddListProduct extends StatefulWidget {
  @override
  _AddListProductState createState() => _AddListProductState();
}

class _AddListProductState extends State<AddListProduct> {
  //Field
  File file;

  //Method

  Widget uploadButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: RaisedButton.icon(
            color: Colors.red,
            onPressed: () {},
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

  Widget nameForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: TextField(
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
      child: file == null ? Image.asset('images/iconfinder_image.png') : Image.file(file),
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
