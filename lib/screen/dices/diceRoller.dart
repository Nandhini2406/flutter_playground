import 'dart:math';
import 'package:flutter/material.dart';
import '../quiz/quiz.dart';
import '../todo/todo.dart';
import '../settings/profile.dart';
import '../../widgets/icon_button.dart';
import '../../widgets/common/styled_text.dart';
import '../../widgets/common/custom_button.dart';

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
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(50.0, 100.0, 50.0, 100.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const StyledText(
                  'Hello Nandhini!',
                  textColor: Color.fromARGB(255, 248, 201, 59),
                  textSize: 22,
                  textWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40.0),
                RotationTransition(
                  turns: _animation,
                  child: Image.asset(
                    'assets/images/dice-$currentDice.png',
                    width: 200,
                    height: 200,
                  ),
                ),
                const SizedBox(height: 20.0),
                TextButton(
                  onPressed: rollDices,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(12.0),
                    backgroundColor: const Color.fromARGB(255, 255, 214, 90),
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w500),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Todo()));
                      },
                      buttonText: 'Todo',
                      buttonIcon: Icons.list,
                    ),
                    const SizedBox(width: 10),
                    CustomButton(
                      bgColor: const Color.fromARGB(100, 0, 0, 0),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Quiz()));
                      },
                      buttonText: 'Quiz',
                      buttonIcon: Icons.book,
                    )
                  ],
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ImageUploadScreen()));
                  },
                  child: const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // const Positioned(
          //   bottom: 0.0,
          //   right: 0.0,
          //   child: IconButtons(),
          // ),
        ],
      ),
      floatingActionButton: const Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: IconButtons(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}