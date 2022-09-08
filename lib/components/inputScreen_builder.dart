import 'package:flutter/material.dart';

class InputScreen extends StatefulWidget {
  @override
  State createState() => new InputScreenState();
}

class InputScreenState extends State<InputScreen> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String userPost = '';
    return Column(children: [
      TextField(
          controller: _textController,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: "Enter",
            border: InputBorder.none,
            suffixIcon: IconButton(
              onPressed: () {
                _textController.clear();
              },
              icon: const Icon(Icons.clear),
            ),
          ),
          onSubmitted: (String text) {
            setState(() {
              userPost = text;
            });
            _textController.clear();
          },
          onChanged: (String text) {
            setState(() {});
          }),
    ]);
  }
}
