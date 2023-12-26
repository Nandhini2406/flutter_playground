import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  const StyledText(this.text, this.textColor, {super.key});

  final String text;
  final Color textColor;

  @override
  Widget build(context) {
    return Text(
      text,
      style: TextStyle(
          color: textColor, fontSize: 24, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }
}
