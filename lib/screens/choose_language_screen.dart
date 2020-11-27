import 'package:flutter/material.dart';

class ChooseLanguageScreen extends StatelessWidget {
  static const routeName = '/choose-language-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ภาษา'),
      ),
      body: Column(
        children: [
          Text("English"),
          Text("Thai"),
          Text("Chinese"),
        ],
      ),
    );
  }
}
