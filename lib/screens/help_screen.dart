import 'package:flutter/material.dart';
import 'package:flutter_hua_yi_tang/custom/custom_divider.dart';
import 'package:flutter_hua_yi_tang/screens/frequently_asked_question_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'add_diagnosis_explanation_screen.dart';

class HelpScreen extends StatelessWidget {
  static const String routeName = '/help-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ช่วยเหลือ'),
      ),
      body: Column(
        children: [
          _ListTileButton(
            icon: Icons.add_to_home_screen,
            text: 'ขั้นตอนการส่งอาการ',
            onTapFn: () {
              Navigator.of(context)
                  .pushNamed(AddDiagnosisExplanationScreen.routeName);
            },
          ),
          CustomDivider(),
          _ListTileButton(
            icon: Icons.report_problem,
            text: 'รายงานปัญหา',
            onTapFn: () async {
              const url = 'https://forms.gle/PjqLADmnWvX54CR4A';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
          CustomDivider(),
          _ListTileButton(
            icon: Icons.question_answer,
            text: 'คำถามที่พบบ่อย',
            onTapFn: () {
              Navigator.of(context)
                  .pushNamed(FrequentlyAskedQuestion.routeName);
            },
          ),
          CustomDivider(),
        ],
      ),
    );
  }
}

class _ListTileButton extends StatelessWidget {
  const _ListTileButton({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.onTapFn,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Function onTapFn;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFn,
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.black,
        ),
        title: Text(
          text,
          softWrap: true,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        trailing: Icon(
          Icons.navigate_next,
          color: Colors.black,
        ),
      ),
    );
  }
}
