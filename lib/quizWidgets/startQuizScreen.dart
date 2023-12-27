import 'package:flutter/material.dart';
import 'package:flutter_playground/customWidgets/CustomButton.dart';
import 'package:flutter_playground/customWidgets/styledText.dart';

class StartQuizScreen extends StatelessWidget {
  const StartQuizScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;
  @override
  Widget build(context) {
    return Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/quiz.png',
            width: 200.0,
            height: 200.0,
          ),
          const SizedBox(height: 40.0),
          const StyledText('Are you Flutter nerd? Try this!', Colors.white),
          const SizedBox(height: 40.0),
          SizedBox(
            width: 120,
            child: CustomButton(
              bgColor: const Color.fromARGB(100, 0, 0, 0),
              onPressed: startQuiz,
              buttonText: 'Start Quiz',
            ),
          ),
        ],
      ),
    );
  }
}
