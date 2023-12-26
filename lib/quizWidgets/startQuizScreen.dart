import 'package:flutter/material.dart';
import 'package:flutter_playground/commonWidgets/CustomButton.dart';
import 'package:flutter_playground/commonWidgets/styledText.dart';

class StartQuizScreen extends StatelessWidget {
  const StartQuizScreen({super.key});
  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 110, 14, 128),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/quiz.png',
              width: 400.0,
              height: 400.0,
            ),
            const SizedBox(height: 30.0),
            const StyledText('Are you Flutter nerd? Try this!', Colors.white),
            const SizedBox(height: 30.0),
            CustomButton(
              bgColor: const Color.fromARGB(100, 0, 0, 0),
              onPressed: () {},
              buttonText: 'Start Quiz',
            ),
          ],
        ),
      ),
    );
  }
}
