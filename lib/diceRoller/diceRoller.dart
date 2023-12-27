import 'dart:math';
import 'package:flutter/material.dart';

import 'package:flutter_playground/customWidgets/styledText.dart';
import 'package:flutter_playground/customWidgets/CustomButton.dart';
import 'package:flutter_playground/quizWidgets/quiz.dart';
import 'package:flutter_playground/todoUI/todoUI.dart';

final random = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var currentDice = 1;

  void rollDices() {
    setState(() {
      currentDice = random.nextInt(6) + 1;
    });
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const StyledText('Hello Nandhini!', Color.fromARGB(255, 245, 192, 32)),
        const SizedBox(height: 40.0),
        Image.asset(
          'assets/images/dice-$currentDice.png',
          width: 200,
          height: 200,
        ),
        const SizedBox(height: 20.0),
        TextButton(
          onPressed: rollDices,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(12.0),
            backgroundColor: const Color.fromARGB(255, 245, 192, 32),
            foregroundColor: Colors.black,
            textStyle:
                const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          child: const Text('Roll dice'),
        ),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              bgColor: const Color.fromARGB(100, 0, 0, 0),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const TodoUI()));
              },
              buttonText: 'Todo',
              buttonIcon: Icons.arrow_forward_rounded,
            ),
            const SizedBox(width: 10),
            CustomButton(
              bgColor: const Color.fromARGB(100, 0, 0, 0),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Quiz()));
              },
              buttonText: 'Quiz',
              buttonIcon: Icons.arrow_forward,
            )
          ],
        ),
      ],
    );
  }
}
