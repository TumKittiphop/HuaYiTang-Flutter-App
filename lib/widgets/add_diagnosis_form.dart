import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hua_yi_tang/custom/custom_underline.dart';
import 'package:flutter_hua_yi_tang/custom/user_image_picker.dart';
import 'package:flutter_hua_yi_tang/screens/main_screen.dart';
import 'package:flutter_hua_yi_tang/screens/medicine_explanation_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../helper/map_of_detail.dart';
import '../screens/main_screen.dart';
import 'package:intl/intl.dart';

class AddDiagnosisForm extends StatefulWidget {
  @override
  _AddDiagnosisFormState createState() => _AddDiagnosisFormState();
}

class _AddDiagnosisFormState extends State<AddDiagnosisForm> {
  bool _feverStatus;
  bool _sweatStatus;
  bool _headacheStatus;
  bool _sleepingStatus;
  bool _excretoryStatus;
  bool _numbessStatus;
  String _feverExplanation;
  String _sweatExplanation;
  String _headacheExplanation;
  String _sleepingExplanation;
  String _excretoryExplanation;
  String _numbessExplanation;
  String _otherExplanation;
  String _proneFeeling;
  String _medicineType;

  File _imageFile;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _sendData(BuildContext ctx) async {
    FocusScope.of(ctx).unfocus();
    final isValid = _formKey.currentState.validate();
    if (_imageFile == null) return _errorSnackBar(ctx, 'กรุณาเลือกรูปภาพ');
    if (_feverStatus == null ||
        _sweatStatus == null ||
        _headacheStatus == null ||
        _sleepingStatus == null ||
        _excretoryStatus == null ||
        _numbessStatus == null ||
        !isValid) {
      return _errorSnackBar(ctx, 'โปรดกรอกข้อมูลให้ครบถ้วน');
    }
    if (_medicineType == null)
      return _errorSnackBar(ctx, 'โปรดเลือกประเภทของยา');

    if (_proneFeeling == null)
      return _errorSnackBar(ctx, 'โปรดเลือกความรู้สึก');

    Timestamp timeStamp = Timestamp.now();
    try {
      final result = await _confirmDialog(ctx);
      if (result != true) return;
      setState(() {
        _isLoading = true;
      });

      final user = await FirebaseAuth.instance.currentUser();
      final userId = user.uid;
      print("Get userId $userId");
      /** Extra for Username */
      final userData = await Firestore.instance
          .collection('user_credentials')
          .document(user.uid)
          .get();
      print(userData);
      /** Add image to FirebaseStorage and get imageUrl*/
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image/' + user.uid)
          .child(
              DateFormat('dd_MM_yyyy_').add_jms().format(timeStamp.toDate()) +
                  '_diagPic' +
                  '.png');
      await ref.putFile(_imageFile).onComplete;
      final _imageUrl = await ref.getDownloadURL();
      print(_imageUrl);

      /**Clear unchecked data */
      if (!_feverStatus) _feverExplanation = null;
      if (!_sweatStatus) _sweatExplanation = null;
      if (!_headacheStatus) _headacheExplanation = null;
      if (!_sleepingStatus) _sleepingExplanation = null;
      if (!_excretoryStatus) _excretoryExplanation = null;
      if (!_numbessStatus) _numbessExplanation = null;

      /** Debug print*/
      print(_feverExplanation);
      print(_sweatExplanation);
      print(_headacheExplanation);
      print(_sleepingExplanation);
      print(_excretoryExplanation);
      print(_numbessExplanation);
      print(_otherExplanation);

      /**Add data to Firestore */
      await Firestore.instance
          .collection('all_diagnosis/$userId/diagnosis')
          .add({
        /**Ordinary Data */
        'feverExplanation': _feverExplanation,
        'sweatExplanation': _sweatExplanation,
        'headacheExplanation': _headacheExplanation,
        'sleepingExplanation': _sleepingExplanation,
        'excretoryExplanation': _excretoryExplanation,
        'numbessExplanation': _numbessExplanation,
        'otherExplanation': _otherExplanation,
        'proneFeeling': _proneFeeling,
        'timeStamp': timeStamp,
        /** Waiting for diagnosis State (1st) */
        'imageUrl': _imageUrl,
        'moreData': false,
        /** Waiting for payment State (2nd) */
        'address': null,
        'price': null,
        /** Checking State (3rd) */
        'invoiceUrl': null,
        /**Done State (4th) */
        'trackingNumber': null,
      });
      setState(() {
        _isLoading = false;
      });
      Navigator.of(ctx).pushReplacementNamed(MainScreen.routeName);
      print("add done");
    } catch (error) {
      _errorSnackBar(ctx, 'โปรดลองอีกครั้ง ในภายหลัง');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _pickedFn(File file) {
    _imageFile = file;
  }

  /// Show error SnackBar
  void _errorSnackBar(BuildContext ctx, String message) {
    Scaffold.of(ctx).hideCurrentSnackBar();
    Scaffold.of(ctx).showSnackBar(SnackBar(
      content: Text(
        'Error : $message',
        style: TextStyle(fontFamily: 'Supermarket'),
      ),
      backgroundColor: Theme.of(context).errorColor,
      duration: Duration(seconds: 2),
    ));
  }

  Future<bool> _confirmDialog(BuildContext ctx) async {
    return Alert(
      context: ctx,
      type: AlertType.info,
      title: "ยืนยันการส่งข้อมูล",
      desc: "หลังจากส่งข้อมูลแล้ว จะไม่สามารถแก้ไขข้อมูลได้",
      closeFunction: () {},
      buttons: [
        DialogButton(
          child: Text(
            "ยกเลิก",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.of(ctx).pop(false),
          color: Colors.grey,
        ),
        DialogButton(
          child: Text(
            "ยืนยัน",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.of(ctx).pop(true),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

  Widget textFormUtil(String textLabel, Function updateFn) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 20,
        left: 20,
        right: 20,
      ),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          labelText: textLabel,
        ),
        onChanged: updateFn,
        validator: (value) {
          if (value.isEmpty) {
            return 'Need information';
          }
          return null;
        },
      ),
    );
  }

  Widget formContainer(String labelText, double width, Function toggleFn,
      Function updateFn, bool groupValue, String initValue) {
    return AnimatedContainer(
      height: groupValue == true ? 150 : 60,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 15),
                    child: AutoSizeText(
                      labelText,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                      maxLines: 1,
                    ),
                  ),
                ),
                Container(
                  width: width * 0.34,
                  child: RadioListTile<bool>(
                    title: const AutoSizeText(
                      'ผิดปกติ',
                      maxLines: 1,
                      style: TextStyle(fontSize: 14),
                    ),
                    value: true,
                    groupValue: groupValue,
                    onChanged: toggleFn,
                  ),
                ),
                Container(
                  width: width * 0.35,
                  child: RadioListTile<bool>(
                    title: AutoSizeText(
                      diagnosisButtonLabel[labelText],
                      style: TextStyle(fontSize: 14),
                      maxLines: 1,
                    ),
                    value: false,
                    groupValue: groupValue,
                    onChanged: toggleFn,
                  ),
                ),
              ],
            ),
            if (groupValue == true)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: Text(
                  diagnosisHeader[labelText],
                  style: TextStyle(fontSize: 16),
                ),
              ),
            if (groupValue == true)
              Container(
                padding: EdgeInsets.only(
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                child: TextFormField(
                  initialValue: initValue,
                  keyboardType: TextInputType.multiline,
                  onChanged: updateFn,
                  decoration: InputDecoration(
                    hintText: diagnosisDetails[labelText],
                    hintStyle: TextStyle(fontSize: 14),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'โปรดกรอกข้อมูลให้ครบถ้วน';
                    }
                    return null;
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //print('add diagnosis form Build');
    double _screenWidth = MediaQuery.of(context).size.width - 20;
    return AbsorbPointer(
      absorbing: _isLoading ? true : false,
      child: Form(
        key: _formKey,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  /**Chosen a Picture*/
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            top: 20,
                            left: 15,
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'เพิ่มรูปภาพ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        CustomUnderline(
                          width: 100,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15, top: 10, bottom: 8),
                          width: double.infinity,
                          child: Text(
                            '- เพิ่มรูปภาพลิ้นของคุณ เพื่อให้แพทย์ใช้ในการวิเคราะห์',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        UserImagePicker(_pickedFn),
                        Container(
                          margin: EdgeInsets.only(
                            top: 4,
                            bottom: 8,
                          ),
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Text(
                            'โปรดเลือกรูปภาพที่มีความละเอียดสูง\nและสีของลิ้นใกล้เคียงกับสีจริงมากที่สุด',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              height: 1.2,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            top: 20,
                            left: 15,
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'อาการเบื้องต้น',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        CustomUnderline(
                          width: 120,
                        ),
                        /**Fever Form */
                        formContainer(
                          'อุณหภูมิร่างกาย',
                          _screenWidth,
                          (bool value) {
                            setState(() {
                              _feverStatus = value;
                            });
                          },
                          (value) {
                            _feverExplanation = value;
                          },
                          _feverStatus,
                          _feverExplanation,
                        ),

                        /**Sweat Form */
                        formContainer(
                          'เหงื่อออก',
                          _screenWidth,
                          (bool value) {
                            setState(() {
                              _sweatStatus = value;
                            });
                          },
                          (value) {
                            _sweatExplanation = value;
                          },
                          _sweatStatus,
                          _sweatExplanation,
                        ),

                        /**headache Form */
                        formContainer(
                          'อาการปวดหัว',
                          _screenWidth,
                          (bool value) {
                            setState(() {
                              _headacheStatus = value;
                            });
                          },
                          (value) {
                            _headacheExplanation = value;
                          },
                          _headacheStatus,
                          _headacheExplanation,
                        ),

                        /**sleeping Form */
                        formContainer(
                          'การนอนหลับ',
                          _screenWidth,
                          (bool value) {
                            setState(() {
                              _sleepingStatus = value;
                            });
                          },
                          (value) {
                            _sleepingExplanation = value;
                          },
                          _sleepingStatus,
                          _sleepingExplanation,
                        ),

                        /**excretory Form */
                        formContainer(
                          'การขับถ่าย',
                          _screenWidth,
                          (bool value) {
                            setState(() {
                              _excretoryStatus = value;
                            });
                          },
                          (value) {
                            _excretoryExplanation = value;
                          },
                          _excretoryStatus,
                          _excretoryExplanation,
                        ),

                        /**numbess Form */
                        formContainer(
                          'อาการชา',
                          _screenWidth,
                          (bool value) {
                            setState(() {
                              _numbessStatus = value;
                            });
                          },
                          (value) {
                            _numbessExplanation = value;
                          },
                          _numbessStatus,
                          _numbessExplanation,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            top: 20,
                            left: 15,
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'รายละเอียดอาการผิดปกติอื่นๆ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        CustomUnderline(
                          width: 200,
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(left: 15, right: 15, bottom: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText:
                                  'อาการที่เพิ่มเติมที่ต้องการแจ้งให้แพทย์ทราบ หรืออาการแพ้',
                              hintStyle: TextStyle(fontSize: 16),
                            ),
                            onChanged: (value) {
                              _otherExplanation = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'โปรดกรอกข้อมูลให้ครบถ้วน';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            top: 20,
                            left: 15,
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'อื่นๆ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        CustomUnderline(
                          width: 80,
                        ),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(
                            left: 8,
                            right: 8,
                            top: 10,
                          ),
                          child: Text(
                            'ความรู้สึก',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              width: _screenWidth * 0.35,
                              child: RadioListTile<String>(
                                title: const AutoSizeText(
                                  'ขี้หนาว',
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 16),
                                ),
                                value: "Cold",
                                groupValue: _proneFeeling,
                                onChanged: (value) {
                                  setState(() {
                                    _proneFeeling = value;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: _screenWidth * 0.3,
                              child: RadioListTile<String>(
                                title: const AutoSizeText(
                                  'ขี้ร้อน',
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 16),
                                ),
                                value: "Hot",
                                groupValue: _proneFeeling,
                                onChanged: (value) {
                                  setState(() {
                                    _proneFeeling = value;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: _screenWidth * 0.35,
                              child: RadioListTile<String>(
                                title: const AutoSizeText(
                                  'ปกติ',
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 16),
                                ),
                                value: "Normal",
                                groupValue: _proneFeeling,
                                onChanged: (value) {
                                  setState(() {
                                    _proneFeeling = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.bottomCenter,
                                margin: EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                ),
                                child: Text(
                                  'ประเภทยาที่ต้องการ',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              ClipOval(
                                child: Material(
                                  child: InkWell(
                                    splashColor: Theme.of(context)
                                        .accentColor, // splash color
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MedicineExplanationScreen(),
                                          fullscreenDialog: true,
                                        ),
                                      );
                                    }, // button pressed
                                    child: Icon(Icons.help), // icon
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              width: _screenWidth * 0.35,
                              child: RadioListTile<String>(
                                title: const AutoSizeText(
                                  'สมุนไพร',
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 16),
                                ),
                                value: "Herb",
                                groupValue: _medicineType,
                                onChanged: (value) {
                                  setState(() {
                                    _medicineType = value;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: _screenWidth * 0.3,
                              child: RadioListTile<String>(
                                title: const AutoSizeText(
                                  'ยาผง',
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 16),
                                ),
                                value: "Mash",
                                groupValue: _medicineType,
                                onChanged: (value) {
                                  setState(() {
                                    _medicineType = value;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: _screenWidth * 0.35,
                              child: RadioListTile<String>(
                                title: const AutoSizeText(
                                  'ยาเม็ด',
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 16),
                                ),
                                value: "Pill",
                                groupValue: _medicineType,
                                onChanged: (value) {
                                  setState(() {
                                    _medicineType = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 5,
              left: 10,
              right: 10,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                width: double.infinity,
                height: 40,
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : RaisedButton(
                        onPressed: () {
                          _sendData(context);
                        },
                        child: Text('ส่งรายละเอียด'),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
