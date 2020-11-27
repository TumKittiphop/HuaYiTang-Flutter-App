import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hua_yi_tang/custom/custom_underline.dart';
import 'package:flutter_hua_yi_tang/custom/user_image_picker.dart';
import 'package:flutter_hua_yi_tang/helper/map_of_detail.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class WaitingForPayment extends StatefulWidget {
  static const routeName = '/waiting-for-payment-screen';

  @override
  _WaitingForPaymentState createState() => _WaitingForPaymentState();
}

class _WaitingForPaymentState extends State<WaitingForPayment> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final int price = args['price'];
    final Timestamp timeStamp = args['timeStamp'];
    final String userId = args['userId'];
    final String documentID = args['documentID'];
    final double _screenWidth = MediaQuery.of(context).size.width;
    void _pickedFn(File file) {
      _imageFile = file;
    }

    void _errorSnackBar(String message) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          '$message',
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
        title: "โปรดสอบข้อมูล",
        desc: "ที่อยู่การจัดส่งจะไม่สามารถแก้ไขได้ หลังจากยืนยัน",
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

    void _addInvoice(BuildContext ctx, String address) async {
      if (_imageFile == null) {
        return _errorSnackBar('โปรดเพิ่มรูปหลักฐานการโอนเงิน');
      }
      final result = await _confirmDialog(ctx);
      if (result != true) return;
      setState(() {
        _isLoading = true;
      });
      final user = await FirebaseAuth.instance.currentUser();

      /** Add image to FirebaseStorage*/
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image/' + user.uid)
          .child(
              DateFormat('dd_MM_yyyy_').add_jms().format(timeStamp.toDate()) +
                  '_invPic' +
                  '.png');
      await ref.putFile(_imageFile).onComplete;
      final url = await ref.getDownloadURL();

      await Firestore.instance
          .collection('all_diagnosis/${user.uid}/diagnosis')
          .document(documentID)
          .updateData({
        'invoiceUrl': url,
        'address': address,
      });
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('รอการชำระเงิน'),
      ),
      body: FutureBuilder(
        future: Firestore.instance
            .collection('user_credentials')
            .document(userId)
            .get(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );

          final userData = userSnapshot.data;
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        left: 10,
                        top: 30,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'ชำระเงินค่ายา',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    CustomUnderline(width: 110),
                    SizedBox(
                      height: 20,
                    ),
                    Container(child: UserImagePicker(_pickedFn)),
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 20),
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'โปรดส่งหลักฐานการโอนเงินจำนวน $price บาท',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 20),
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'โปรดโอนเงินให้พอดี ไปยังเลขที่บัญชีด้านล่าง',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            'ที่อยู่การจัดส่งยา : ',
                            softWrap: true,
                            style: TextStyle(height: 1.3, fontSize: 18),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          width: _screenWidth * 0.4,
                          child: Text(
                            userData['address'],
                            softWrap: true,
                            style: TextStyle(height: 1.3, fontSize: 18),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      elevation: 7,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: ListTile(
                        leading: Image.network(bankAccount['SCB']['imageUrl']),
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: bankAccount['SCB']['number'] + " ",
                                style: TextStyle(
                                  fontFamily: 'Supermarket',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  letterSpacing: 1,
                                ),
                              ),
                              TextSpan(
                                text: bankAccount['SCB']['bankName'],
                                style: TextStyle(
                                  fontFamily: 'Supermarket',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        subtitle: Text(
                          bankAccount['SCB']['accountName'],
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.content_copy),
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(
                                text: bankAccount['SCB']['number']
                                    .replaceAllMapped('-', (match) => ''),
                              ),
                            );
                            _scaffoldKey.currentState.hideCurrentSnackBar();
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text(
                                'คัดลอกเลขที่บัญชีเรียบร้อย',
                                style: TextStyle(fontFamily: 'Supermarket'),
                              ),
                              backgroundColor: Colors.grey,
                              duration: Duration(seconds: 2),
                            ));
                          },
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  width: double.infinity,
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : RaisedButton(
                          child: Text('ส่ง'),
                          onPressed: () {
                            _addInvoice(
                              context,
                              userData['address'],
                            );
                          }),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
