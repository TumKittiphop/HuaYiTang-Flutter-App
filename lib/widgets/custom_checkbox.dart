import 'package:flutter/material.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    this.containerWidth,
    this.label,
    this.padding,
    this.value,
    this.onChanged,
  });
  final containerWidth;
  final String label;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: () {
        onChanged(!value);
      },
      child: Container(
      
        width: containerWidth,
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(label),
            ),
            Checkbox(
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}
