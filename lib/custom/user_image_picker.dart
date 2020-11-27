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
  void _addImage(BuildContext ctx) async {
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
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () {
        _addImage(context);
      },
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(30),
        ),
        child: _chosenImage == null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.publish,
                    size: 40,
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(
                    'เพิ่มรูปภาพ',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                    ),
                  ),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.file(
                  _chosenImage,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
