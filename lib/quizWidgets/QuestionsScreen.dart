import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_playground/customWidgets/styledText.dart';
import 'package:flutter_playground/quizWidgets/answer_Button.dart';
import 'package:flutter_playground/data/questions.dart';
import 'package:flutter_playground/quizWidgets/result_Screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';


class QuestionsScreen extends StatefulWidget {
   QuestionsScreen({super.key});
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
    setState(() {
      if (!quizCompleted && currentIndex < questions.length - 1) {
        selectedAnswers.add(answers);
        currentIndex++;
        print('Current index $currentIndex');
      } else {
        selectedAnswers.add(answers);
        quizCompleted = true;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              selectedAnswers: selectedAnswers,
            ),
          ),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentIndex];
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StyledText(
              currentQuestion.question,
              textAlign: TextAlign.center,
              textSize: 20,
              textColor: Colors.white,
              textWeight: FontWeight.normal,
            ),
            const SizedBox(height: 20.0),
            ...currentQuestion.getShuffledAnswers.map((answers) {
              return AnswerButton(
                answerText: answers,
                onTap: () {
                  answerQuestion(answers);
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
