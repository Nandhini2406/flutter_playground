import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledText extends StatelessWidget {
  const StyledText(
    this.text, {
    super.key,
    required this.textColor,
    required this.textSize,
    required this.textWeight,
    required this.textAlign,
  });

  final String text;
  final Color textColor;
  final double textSize;
  final FontWeight textWeight;
  final TextAlign textAlign;

  @override
  Widget build(context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: textColor,
        fontSize: textSize,
        fontWeight: textWeight,
      ),
      textAlign: textAlign,
    );
  }
}
