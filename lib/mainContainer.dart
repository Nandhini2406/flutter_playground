import 'package:flutter/material.dart';

import 'package:flutter_playground/diceRoller/diceRoller.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({super.key});

  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(50.0, 200.0, 50.0, 200.0),
      decoration: BoxDecoration(
          // color: const Color.fromARGB(50, 0, 0, 0),
          borderRadius: BorderRadius.circular(15)),
      child: const DiceRoller(),
    );
  }
}
