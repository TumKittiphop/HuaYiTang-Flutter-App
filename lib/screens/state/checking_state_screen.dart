import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hua_yi_tang/custom/custom_underline.dart';
import 'package:flutter_hua_yi_tang/widgets/show_network_image.dart';

class CheckingStateScreen extends StatelessWidget {
  static const String routeName = '/checking-state-screen';
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final String _invoiceUrl = args['invoiceUrl'];
    final String _address = args['address'];
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('กำลังตรวจสอบ')),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 10,
              top: 30,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              'รอการตรวจสอบ',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CustomUnderline(width: 140),
          Container(
            padding: EdgeInsets.only(top: 30),
            child: ShowNetworkImage(_invoiceUrl),
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
                  _address,
                  softWrap: true,
                  style: TextStyle(height: 1.3, fontSize: 18),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
