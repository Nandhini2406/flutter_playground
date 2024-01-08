import 'package:flutter/material.dart';
import 'package:flutter_playground/customWidgets/styledText.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.answerText,
    required this.onTap,
  });

  final String answerText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 40,
            ),
            backgroundColor: const Color.fromARGB(221, 84, 4, 91),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: StyledText(
            answerText,
            textSize: 18,
            textColor: Colors.white,
            textWeight: FontWeight.w500,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 6.0)
      ],
    );
  }
}
