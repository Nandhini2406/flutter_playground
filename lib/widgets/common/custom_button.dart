import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.bgColor,
      required this.onPressed,
      this.buttonText,
      this.buttonIcon});

  final VoidCallback onPressed;
  final Color bgColor;
  final String? buttonText;
  final IconData? buttonIcon;

  @override
  Widget build(context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          backgroundColor: bgColor,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              buttonText!,
              textAlign: TextAlign.center,
            ),
            if (buttonIcon != null) const SizedBox(width: 8),
            Icon(buttonIcon),
          ],
        ));
  }
}
