import 'package:flutter/material.dart';
import 'package:flutter_hua_yi_tang/custom/custom_underline.dart';
import '../helper/map_of_detail.dart';

class AddDiagnosisExplanationScreen extends StatelessWidget {
  static const routeName = '/add-diagnosis-explanation-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดการส่ง'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'ขั้นตอนการส่งอาการออนไลน์',
                style: TextStyle(
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            CustomUnderline(
              width: 230,
            ),
            for (int i = 1; i <= diagnosticSendingSteps.length; i++)
              Container(
                margin: EdgeInsets.all(12),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      child: Text(i.toString()),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        diagnosticSendingSteps[i - 1],
                        textAlign: TextAlign.left,
                        softWrap: true,
                        style: TextStyle(height: 1.2, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
