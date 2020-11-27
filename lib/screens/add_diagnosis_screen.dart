import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hua_yi_tang/widgets/add_diagnosis_form.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddDiagnosisScreen extends StatelessWidget {
  static const String routeName = '/add-diagnosis-screen';

  Future<bool> _confirmDialog(BuildContext ctx) async {
    final result = await Alert(
      context: ctx,
      type: AlertType.warning,
      title: "ออกจากหน้านี้",
      desc: "คุณอาจจะต้องกรอกข้อมูลใหม่",
      closeFunction: () {
        return false;
      },
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
            "ออก",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.of(ctx).pop(true),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0),
          ]),
        )
      ],
    ).show();

    if (result != true) return false;
    return true;
  }

  Future<FirebaseUser> _initUserData() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    await userData.reload();
    return await FirebaseAuth.instance.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แบบฟอร์ม'),
      ),
      body: FutureBuilder(
        future: _initUserData(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final FirebaseUser userData = userSnapshot.data;
          print('Vertified: ' + userData.isEmailVerified.toString());
          return !userData.isEmailVerified
              ? Center(
                  child: Text(
                    'โปรดยืนยันตัวตนโดยคลิกลิ้งที่ส่งไปทางอีเมล\nอาจจะอยู่ในช่องอีเมลขยะ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                      height: 1.2,
                    ),
                  ),
                )
              : FutureBuilder(
                  future: Firestore.instance
                      .collection('all_diagnosis/${userData.uid}/diagnosis')
                      .where('state', isEqualTo: "WaitingForDiagnosis")
                      .getDocuments(),
                  builder: (context, dataSnapshot) {
                    if (dataSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    print("WaitingForDiagnosis: " +
                        dataSnapshot.data.documents.length.toString());
                    return dataSnapshot.data.documents.length >= 3
                        ? Center(
                            child: Text(
                              'ขออภัย สามารถส่งได้สูงสุด 3 ครั้งเท่านั้น\nโปรดรอการวิเคราะห์',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontStyle: FontStyle.italic,
                                height: 1.2,
                              ),
                            ),
                          )
                        : WillPopScope(
                            onWillPop: () => _confirmDialog(context),
                            child: AddDiagnosisForm(),
                          );
                  },
                );
        },
      ),
    );
  }
}
