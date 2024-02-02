import 'dart:math';
import 'package:flutter/material.dart';
import '../../widgets/icon_button.dart';

final random = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({Key? key}) : super(key: key);

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  var currentDice = 1;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 100.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  void rollDices() {
    setState(() {
      currentDice = random.nextInt(6) + 1;
      _controller.reset(); // Reset the animation to its initial state.
      _controller.forward(); // Start the spinning animation.
    });
  }

  @override
  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(163, 144, 0, 199),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            RotationTransition(
              turns: _animation,
              child: Image.asset(
                'assets/images/dice-$currentDice.png',
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(height: 40.0),
            TextButton(
              onPressed: rollDices,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(12.0),
                backgroundColor: const Color.fromARGB(255, 255, 214, 90),
                foregroundColor: Colors.black,
                textStyle:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              child: const Text('Roll dice'),
            ),
          ],
        ),
      ),
      floatingActionButton: const IconButtons(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
