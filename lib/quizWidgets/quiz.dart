import 'package:flutter/material.dart';
import '../quizWidgets/QuestionsScreen.dart';
import '../quizWidgets/start_quiz_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  Widget? activeScreen;
  @override
  void initState() {
    //used to instancely create variable and function at same time while widget is created
    activeScreen = StartQuizScreen(switchScreen);
    super.initState();
  }

  void switchScreen() {
    setState(() {
      activeScreen = QuestionsScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 110, 14, 128),
        body: Container(child: activeScreen));
  }
}
