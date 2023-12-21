import 'package:flutter/material.dart';

import 'package:flutter_playground/styledText.dart';
import 'package:flutter_playground/todoUI.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({super.key});

  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(50.0, 200.0, 50.0, 200.0),
      decoration: BoxDecoration(
          color: const Color.fromARGB(50, 0, 0, 0),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: StyledText(
              'Hello Nandhini!',
            ),
          ),
          const SizedBox(height: 50.0),
          Image.asset(
            'assets/images/dice-1.png',
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 10.0),
          TextButton(
              onPressed: () {},
              child: const Text(
                'Roll dice',
                style: TextStyle(color: Colors.yellow),
              )),
          OutlinedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TodoUI()));
            },
            child: const Text(
              'Todo',
              style: TextStyle(color: Colors.yellow),
            ),
            // style: ButtonStyle(backgroundColor: Colors.blue),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
