import 'package:flutter/material.dart';
import 'package:flutter_hua_yi_tang/screens/state/done_state_screen.dart';
import 'package:flutter_hua_yi_tang/screens/state/waiting_for_dianosis_screen.dart';

MaterialColor getColor(String state) {
  if (state == 'WaitingForDiagnosis') return Colors.yellow;
  if (state == 'WaitingForPayment') return Colors.blue;
  if (state == 'Checking') return Colors.amber;
  if (state == 'Done') return Colors.green;
  return Colors.red;
}

String getTitle(String state) {
  if (state == 'WaitingForDiagnosis') return 'รอการวิเคราะห์';
  if (state == 'WaitingForPayment') return 'รอการชำระเงิน';
  if (state == 'Checking') return 'กำลังตรวจสอบ';
  if (state == 'Done') return 'เสร็จสิ้น';
  return 'เกิดข้อผิดพลาด';
}

IconData getIcon(String state) {
  if (state == 'WaitingForDiagnosis') return Icons.hourglass_empty;
  if (state == 'WaitingForPayment') return Icons.credit_card;
  if (state == 'Checking') return Icons.verified_outlined;
  if (state == 'Done') return Icons.done;
  return Icons.error;
}

String getRouteName(BuildContext context, String state) {
  if (state == 'WaitingForDiagnosis')
    return WaitingForDiagnosisScreen.routeName;
  if (state == 'WaitingForPayment') return WaitingForDiagnosisScreen.routeName;
  if (state == 'Done') return DoneStateScreen.routeName;

  return WaitingForDiagnosisScreen.routeName;
}
