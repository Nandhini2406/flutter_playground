import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      body: Container(
          child: const Text(
        'Result here...',
        style: TextStyle(fontSize: 18),
      )),
    );
  }
}
