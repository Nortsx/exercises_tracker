import 'package:exercises_tracker/components/dropdownScreen_builder.dart';
import 'package:exercises_tracker/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:exercises_tracker/viewmodels/trainings_view_model.dart';
import 'package:provider/provider.dart';

class InputScreen extends StatefulWidget {
  @override
  State createState() => new InputScreenState();
}

class InputScreenState extends State<InputScreen> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TrainingsViewModel trainingsViewModel = context.watch<TrainingsViewModel>();
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
              if (text[0] == '-' || text == '0') {
                showAlertDialog();
              } else {
                trainingsViewModel.increaseAmountOfCompleted(userPost);
              }
            });
            _textController.clear();
          },
          onChanged: (String text) {
            setState(() {});
          }),
    ]);
  }

  void showAlertDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32))),
            title: new Text("Can't enter this qantity of exercises"),
            content: new Text(
                "You can't enter value which's lower or equal to zero."),
            actions: [
              new TextButton(
                child: new Text("OK"),
                onPressed: (() => Navigator.pop(context, true)),
              )
            ],
          );
        });
  }
}
