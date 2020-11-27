import 'package:flutter/material.dart';
import 'package:flutter_hua_yi_tang/custom/custom_divider.dart';
import 'package:flutter_hua_yi_tang/screens/toggle_faceid_screen.dart';

import 'choose_language_screen.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = '/setting-screen';

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
            text: 'ภาษา',
            onTapFn: () {
              Navigator.of(context).pushNamed(ChooseLanguageScreen.routeName);
            },
          ),
          CustomDivider(),
          _ListTileButton(
            icon: Icons.question_answer,
            text: 'FaceID/TouchID',
            onTapFn: () {
              Navigator.of(context).pushNamed(ToggleFaceIDScreen.routeName);
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
