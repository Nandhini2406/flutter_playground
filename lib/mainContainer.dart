import 'package:flutter/material.dart';

import 'package:flutter_playground/diceRoller/diceRoller.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(164, 12, 114, 203),
        body: Container(
          margin: const EdgeInsets.fromLTRB(50.0, 100.0, 50.0, 100.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: const DiceRoller(),
        ),
      ),
    );
  }
}
