import 'package:flutter/material.dart';
import '../diceRoller/diceRoller.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({super.key});

  @override
  Widget build(context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DiceRoller(),
    );
  }
}
