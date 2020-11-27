import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File file) pickFn;
  UserImagePicker(this.pickFn);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _chosenImage;
  void addImage(BuildContext ctx) async {
    final imageSource = await showModalBottomSheet(
      context: ctx,
      builder: (ctx) => Container(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: RaisedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop(ImageSource.gallery);
                },
                icon: Icon(Icons.photo_library),
                label: Text('เลือกจากแกลลอรี่'),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: RaisedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop(ImageSource.camera);
                },
                icon: Icon(Icons.camera_alt),
                label: Text('เปิดกล้องถ่ายรูป'),
              ),
            ),
          ],
        ),
      ),
    );
    if (imageSource == null) return;
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: imageSource,
    );
    if (pickedFile == null) return;
    setState(() {
      _chosenImage = File(pickedFile.path);
    });
    widget.pickFn(_chosenImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                image: _chosenImage == null
                    ? AssetImage('lib/assets/images/waiting_for_image.png')
                    : FileImage(_chosenImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        FlatButton.icon(
          onPressed: () {
            addImage(context);
          },
          icon: Icon(Icons.add_photo_alternate),
          label: Text('เพิ่มรูปภาพ'),
        ),
      ],
    );
  }
}
