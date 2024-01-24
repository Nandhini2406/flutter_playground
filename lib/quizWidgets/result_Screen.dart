import 'package:flutter/material.dart';
import 'package:flutter_playground/utils/notification_service.dart';
import 'package:flutter_playground/customWidgets/CustomButton.dart';
import 'package:flutter_playground/customWidgets/styledText.dart';
import 'package:flutter_playground/data/questions.dart';
import 'package:flutter_playground/quizWidgets/quiz.dart';
import 'package:flutter_playground/quizWidgets/result_Summary.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.selectedAnswers});
  final List<String> selectedAnswers;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
    setupNotification();
  }

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < widget.selectedAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].question,
          'correct_answer': questions[i].answers[0],
          'user_answer': widget.selectedAnswers[i]
        },
      );
    }
    return summary;
  }

  void showNotification(numCorrectQuestions) {

    flutterLocalNotificationsPlugin.show(
      0,
      "Quiz completed",
      "Source $numCorrectQuestions",
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: Importance.high,
          color: Colors.blue,
          playSound: true,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = getSummaryData()
        .where((data) => data['user_answer'] == data['correct_answer'])
        .toList()
        .length;
    showNotification(numCorrectQuestions);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 110, 14, 128),
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            StyledText(
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly',
              textSize: 22,
              textColor: Colors.white,
              textWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ResultSummary(getSummaryData()),
            // Expanded(
            //   child: ListView.builder(
            //     padding: const EdgeInsets.all(20),
            //     itemCount: selectedAnswers.length,
            //     itemBuilder: (context, index) {
            //       return Column(
            //         children: [
            //           Text(
            //             questions[index].question,
            //             textAlign: TextAlign.left,
            //             style: const TextStyle(
            //                 fontSize: 18,
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.w600),
            //           ),
            //           Text(
            //             selectedAnswers[index],
            //             textAlign: TextAlign.left,
            //             style: const TextStyle(
            //                 fontSize: 18,
            //                 color: Color.fromARGB(255, 0, 255, 229),
            //                 fontWeight: FontWeight.w500),
            //           ),
            //           Text(
            //             questions[index].answers[0],
            //             textAlign: TextAlign.left,
            //             style: const TextStyle(
            //                 fontSize: 18,
            //                 color: Color.fromARGB(255, 0, 255, 229),
            //                 fontWeight: FontWeight.w500),
            //           ),
            //         ],
            //       );
            //     },
            //   ),
            // ),
            const SizedBox(height: 40),
            CustomButton(
              bgColor: const Color.fromARGB(97, 94, 11, 109),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Quiz(),
                  ),
                );
              },
              buttonText: 'Restart Quiz',
              buttonIcon: Icons.refresh,
            )
          ],
        ),
      ),
    );
  }
}