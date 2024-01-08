import 'package:flutter/material.dart';
import 'package:flutter_playground/customWidgets/CustomButton.dart';
import 'package:flutter_playground/customWidgets/styledText.dart';

class StartQuizScreen extends StatelessWidget {
  const StartQuizScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;
  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/quiz.png',
            width: 200.0,
            height: 200.0,
          ),
          const SizedBox(height: 40.0),
          const StyledText(
            'Are you Flutter nerd? Try this!',
            textColor: Colors.white,
            textSize: 20,
            textWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40.0),
          CustomButton(
            bgColor: const Color.fromARGB(100, 0, 0, 0),
            onPressed: startQuiz,
            buttonText: 'Start Quiz',
          ),
        ],
      ),
    );
  }
}
