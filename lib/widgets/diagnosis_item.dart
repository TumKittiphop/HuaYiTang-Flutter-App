import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hua_yi_tang/helper/status_helper.dart';
import 'package:flutter_hua_yi_tang/screens/state/checking_state_screen.dart';
import 'package:flutter_hua_yi_tang/screens/state/done_state_screen.dart';
import 'package:flutter_hua_yi_tang/screens/state/waiting_for_dianosis_screen.dart';
import 'package:flutter_hua_yi_tang/screens/state/waiting_for_payment_screen.dart';
import 'package:intl/intl.dart';

class DiagnosisItem extends StatelessWidget {
  final String documentID;
  final String userId;
  final String state;
  final Timestamp timeStamp;
  final String feverExplanation;
  final String sweatExplanation;
  final String headacheExplanation;
  final String sleepingExplanation;
  final String excretoryExplanation;
  final String numbessExplanation;
  final String otherExplanation;
  final String imageUrl;
  final String address;
  final bool moreData;
  final int price;
  final String invoiceUrl;
  final String trackingNumber;
  DiagnosisItem({
    @required this.documentID,
    @required this.userId,
    @required this.state,
    @required this.timeStamp,
    @required this.feverExplanation,
    @required this.sweatExplanation,
    @required this.headacheExplanation,
    @required this.sleepingExplanation,
    @required this.excretoryExplanation,
    @required this.numbessExplanation,
    @required this.otherExplanation,
    @required this.imageUrl,
    @required this.address,
    @required this.moreData,
    @required this.price,
    @required this.invoiceUrl,
    @required this.trackingNumber,
  });

  @override
  Widget build(BuildContext context) {
    print(state);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      child: Card(
        elevation: 8.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: InkWell(
          onTap: () {
            /** Done State (4th) */
            if (state == 'WaitingForDiagnosis')
              Navigator.of(context)
                  .pushNamed(WaitingForDiagnosisScreen.routeName, arguments: {
                'imageUrl': imageUrl,
                'feverExplanation': feverExplanation,
                'sweatExplanation': sweatExplanation,
                'headacheExplanation': headacheExplanation,
                'sleepingExplanation': sleepingExplanation,
                'excretoryExplanation': excretoryExplanation,
                'numbessExplanation': numbessExplanation,
                'otherExplanation': otherExplanation,
              });
            else if (state == 'WaitingForPayment')
              Navigator.of(context)
                  .pushNamed(WaitingForPayment.routeName, arguments: {
                'price': price,
                'timeStamp': timeStamp,
                'userId': userId,
                'documentID': documentID,
              });
            else if (state == 'Checking') {
              Navigator.of(context)
                  .pushNamed(CheckingStateScreen.routeName, arguments: {
                'invoiceUrl': invoiceUrl,
                'address': address,
              });
            } else if (state == 'Done')
              Navigator.of(context).pushNamed(DoneStateScreen.routeName);
          },
          child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                      width: 1.0, color: Theme.of(context).primaryColor),
                ),
              ),
              child: Icon(
                getIcon(state),
                color: getColor(state),
                size: 35,
              ),
            ),
            title: Text(
              getTitle(state),
              style: Theme.of(context).textTheme.headline5,
            ),
            subtitle: Text(
              //**Dont show seconds because it's only show on screen which is enough*/
              DateFormat.yMd().add_jm().format(timeStamp.toDate()),
              style: Theme.of(context).textTheme.subtitle2,
            ),
            trailing: Icon(Icons.keyboard_arrow_right,
                color: Theme.of(context).primaryColor, size: 30.0),
          ),
        ),
      ),
    );
  }
}
