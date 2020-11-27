import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: 20,
      endIndent: 20,
      thickness: 1,
      height: 0,
    );
  }
}
