import 'package:flutter/material.dart';

class TodoUI extends StatefulWidget {
  const TodoUI({super.key});
  @override
  _TodoUIState createState() => _TodoUIState();
}

class _TodoUIState extends State<TodoUI> {
  final TextEditingController _textFieldController1 = TextEditingController();
  final TextEditingController _textFieldController2 = TextEditingController();
  String _enteredText1 = '';
  String _enteredText2 = '';

  @override
  Widget build(context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 100.0),
        decoration: BoxDecoration(
            color: const Color.fromARGB(63, 255, 222, 103),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  // controller: _textFieldController1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a search term',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: _textFieldController2,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your username',
                ),
              ),
            ),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    _enteredText1 = _textFieldController1.text;
                    _enteredText2 = _textFieldController2.text;
                  });
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.amber)),
                child: const Text(
                  'Add',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Todo 1: $_enteredText1',
              style: const TextStyle(fontSize: 18),
            ), // to display the todo list
            Text(
              'Todo 2: $_enteredText2',
              style: const TextStyle(fontSize: 18),
            ), // to display the todo list
          ],
        ),
      ),
    );
  }
}
