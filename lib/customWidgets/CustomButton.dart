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
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(15.0),
          backgroundColor: bgColor,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        child: Center(
          child: Row(
            children: [
              Text(
                buttonText!,
                textAlign: TextAlign.center,
              ),
              const SizedBox(width: 8),
              if (buttonIcon != null) Icon(buttonIcon),
            ],
          ),
        ));
  }
}
