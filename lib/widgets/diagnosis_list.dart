import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hua_yi_tang/assets/style/style.dart';
import 'package:flutter_hua_yi_tang/screens/add_diagnosis_screen.dart';
import 'package:flutter_hua_yi_tang/widgets/diagnosis_item.dart';

class DiagnosisList extends StatefulWidget {
  @override
  _DiagnosisListState createState() => _DiagnosisListState();
}

class _DiagnosisListState extends State<DiagnosisList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (userSnapshot.hasError) {
          return SliverFillRemaining(
            child: TextAndButton(
              content: 'An error occurred',
              buttonText: 'Retry',
              onPressed: () {},
            ),
          );
        }
        String userId = userSnapshot.data.uid;

        if (userSnapshot.hasData) {
          return StreamBuilder(
            stream: Firestore.instance
                .collection('all_diagnosis/$userId/diagnosis')
                .orderBy('timeStamp', descending: true)
                .snapshots(),
            builder: (context, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final dataDocs = dataSnapshot.data.documents;
              if (dataDocs.length == 0) {
                return SliverList(
                  delegate: SliverChildListDelegate([
                    SizedBox(height: 80),
                    Image.network(
                      'https://image.flaticon.com/icons/png/512/31/31116.png',
                      height: 100,
                      fit: BoxFit.fitHeight,
                    ),
                    SizedBox(height: 40),
                    Center(
                      child: Text(
                        'ยังไม่มีการวิเคราะห์',
                        style: TextStyle(
                          fontFamily: 'Supermarket',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'ส่งอาการให้แพทย์วิเคราะห์ ',
                              style: TextStyle(
                                fontFamily: 'Supermarket',
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: 'คลืกที่นี่ (ฟรี)',
                              style: TextStyle(
                                fontFamily: 'Supermarket',
                                fontSize: 20,
                                color: ownColors['Primary'],
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context)
                                      .pushNamed(AddDiagnosisScreen.routeName);
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                  ]),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    String _state;
                    if (dataDocs[index]['trackingNumber'] != null)
                      _state = 'Done';
                    else if (dataDocs[index]['invoiceUrl'] != null)
                      _state = 'Checking';
                    else if (dataDocs[index]['price'] != null)
                      _state = 'WaitingForPayment';
                    else
                      _state = 'WaitingForDiagnosis';

                    return Container(
                      child: DiagnosisItem(
                        documentID: dataDocs[index].documentID,
                        userId: userId,
                        state: _state,
                        timeStamp: dataDocs[index]['timeStamp'],
                        feverExplanation: dataDocs[index]['feverExplanation'],
                        sweatExplanation: dataDocs[index]['sweatExplanation'],
                        headacheExplanation: dataDocs[index]
                            ['headacheExplanation'],
                        sleepingExplanation: dataDocs[index]
                            ['sleepingExplanation'],
                        excretoryExplanation: dataDocs[index]
                            ['excretoryExplanation'],
                        numbessExplanation: dataDocs[index]
                            ['numbessExplanation'],
                        otherExplanation: dataDocs[index]['otherExplanation'],
                        imageUrl: dataDocs[index]['imageUrl'],
                        address: dataDocs[index]['address'],
                        moreData: dataDocs[index]['moreData'],
                        price: dataDocs[index]['price'],
                        invoiceUrl: dataDocs[index]['invoiceUrl'],
                        trackingNumber: dataDocs[index]['trackingNumber'],
                      ),
                    );
                  },
                  childCount: dataDocs.length,
                ),
              );
            },
          );
        }
        return SliverFillRemaining(
          child: Center(child: Text('No Content')),
        );
      },
    );
  }
}

class TextAndButton extends StatelessWidget {
  const TextAndButton({Key key, this.content, this.buttonText, this.onPressed})
      : super(key: key);
  final String content;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            content,
            style: Theme.of(context).textTheme.headline,
          ),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Text(buttonText,
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(color: Colors.white)),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
