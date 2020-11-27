import 'package:flutter/material.dart';
import 'package:flutter_hua_yi_tang/custom/custom_underline.dart';

class DoneStateScreen extends StatelessWidget {
  static const routeName = '/done-state-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เสร็จสิ้น'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              left: 10,
              top: 30,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              'ยาของคุณอยู่ระหว่างการจัดส่ง',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CustomUnderline(width: 240),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(
              left: 10,
            ),
            width: double.infinity,
            child: Text(
              'การขนส่งอาจใช้เวลาประมาณ 2-3 วัน',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 5,
              left: 10,
            ),
            width: double.infinity,
            child: Text(
              'เลขเพื่อติมตามพัสดุ คือ asdadasdsadsd',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              left: 10,
              top: 30,
            ),
            child: Text(
              'ผลลัพธ์ หลังจากรับประทานยา',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CustomUnderline(width: 240),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              width: double.infinity,
              child: TextField(
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'เพื่อใช้ในการวิเคราห์ครั้งต่อไป',
                  hintStyle: TextStyle(fontSize: 18),
                ),
              )),
        ],
      ),
    );
  }
}
