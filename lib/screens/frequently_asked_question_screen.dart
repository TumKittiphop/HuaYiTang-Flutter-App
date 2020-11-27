import 'package:flutter/material.dart';

class FrequentlyAskedQuestion extends StatelessWidget {
  static const String routeName = '/frequently-asked-question-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('คำถามที่พบบ่อย'),
      ),
      body: Column(
        children: [Text('Coming soon!')],
      ),
    );
  }
}
