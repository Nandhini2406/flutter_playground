import 'package:flutter/material.dart';
import 'package:flutter_playground/quizWidgets/answer_Button.dart';
import 'package:flutter_playground/data/questions.dart';
import 'package:flutter_playground/quizWidgets/result_Screen.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentIndex = 0;
  List<String> selectedAnswers = [];
  bool quizCompleted = false;

  // void answerQuestion(String answers) {
  //   if (!quizCompleted && currentIndex < questions.length) {
  //     setState(() {
  //       currentIndex = currentIndex + 1;
  //       selectedAnswers.add(answers);
  //     });
  //     print('Current isndex $currentIndex');
  //   } else {
  //     print('last isndex $currentIndex');
  //     Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => ResultScreen(
  //                   selectedAnswers: selectedAnswers,
  //                 )));
  //   }
  // }

  void answerQuestion(String answers) {
    setState(() {}); // Call setState once at the end to trigger a rebuild.

    if (!quizCompleted && currentIndex < questions.length - 1) {
      selectedAnswers.add(answers);
      currentIndex = currentIndex + 1;
      print('Current index $currentIndex');
    } else {
      quizCompleted = true;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            selectedAnswers: selectedAnswers,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentIndex];
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.question,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20.0),
            ...currentQuestion.getShuffledAnswers().map((answers) {
              return AnswerButton(
                  answerText: answers,
                  onTap: () {
                    answerQuestion(answers);
                  });
            })
          ],
        ),
      ),
    );
  }
}
