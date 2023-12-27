import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.selectedAnswers});
  final List<String> selectedAnswers;
  @override
  Widget build(context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text(
              'Result here...',
              style: TextStyle(fontSize: 18),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: selectedAnswers.length,
                itemBuilder: (context, index) {
                  return Text(
                    selectedAnswers[index],
                    style: const TextStyle(fontSize: 18),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
