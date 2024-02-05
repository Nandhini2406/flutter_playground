import 'package:flutter/material.dart';
import 'screen/dices/diceRoller.dart';
import 'screen/quiz/quiz.dart';
import 'screen/todo/todo.dart';
import 'screen/settings/profile.dart';
import 'screen/settings/settings.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedTab = 0;

  static const List<Widget> _screens = [
    DiceRoller(),
    Todo(),
    Quiz(),
    Settings(),
  ];

  void _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _screens[_selectedTab],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          onTap: (index) => _changeTab(index),
          selectedItemColor: const Color.fromARGB(163, 144, 0, 199),
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.square),
              label: "Dices",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "Todo",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_mail),
              label: "Quiz",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),

      // ,
    );
  }
}
