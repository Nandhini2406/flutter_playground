import 'package:flutter/material.dart';

import 'package:flutter_playground/customWidgets/styledText.dart';

class TodoUI extends StatefulWidget {
  const TodoUI({super.key});
  @override
  _TodoUIState createState() => _TodoUIState();
}

class _TodoUIState extends State<TodoUI> {
  final TextEditingController _textFieldController = TextEditingController();
  String _enteredText = '';

  @override
  Widget build(context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 60.0),
        decoration: BoxDecoration(
            color: const Color.fromARGB(63, 255, 222, 103),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const StyledText(
              'Todo List: ',
              textColor: Colors.black,
              textSize: 20,
              textAlign: TextAlign.start,
              textWeight: FontWeight.bold,
            ),
            Text(
              _enteredText,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Row(children: [
              Expanded(
                child: TextFormField(
                  controller: _textFieldController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Add Your Todo List',
                    labelStyle: TextStyle(
                        color: Color.fromARGB(255, 187, 10, 48), fontSize: 1),
                    focusColor: Colors.amberAccent,
                  ),
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              IconButton(
                onPressed: () {
                  setState(() {
                    _enteredText = _textFieldController.text;
                  });
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.amber)),
                icon: const Icon(Icons.add),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
