import 'package:exercises_tracker/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PushupsGoalButton extends StatefulWidget {
  @override
  State createState() => new PushupsGoalButtonState();

  late String sportType = "";

  PushupsGoalButton(String typeOfSportPicked) {
    sportType = typeOfSportPicked;
  }
}

class PushupsGoalButtonState extends State<PushupsGoalButton> {
  List<int> quantityToBeCompleted = <int>[
    100,
    150,
    200,
    250,
    300,
  ];
  late int dropDownValue;

  @override
  Widget build(BuildContext context) {
    var userViewModel = context.watch<UserViewModel>();
    dropDownValue = userViewModel.tempOverallGoals["Push-ups"]!;
    return DropdownButton(
        value: dropDownValue,
        items: quantityToBeCompleted.map<DropdownMenuItem<int>>(
          (int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(
                value.toString(),
                style: TextStyle(fontSize: 18),
              ),
            );
          },
        ).toList(),
        onChanged: (int? newValue) {
          setState(() {
            dropDownValue = newValue!;
            print(userViewModel.trainingModel.type + " PUSHUPS GOAL BUTTON");
            userViewModel.updateQuantityGoal(widget.sportType, dropDownValue);
          });
        });
  }
}
