import 'package:flutter/material.dart';

class CustomUnderline extends StatelessWidget {
  final double width;

  CustomUnderline({
    @required this.width,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(500),
          bottomRight: Radius.circular(500),
        ),
        child: Container(
          width: width,
          height: 4,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
