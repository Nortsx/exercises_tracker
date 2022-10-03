import 'package:exercises_tracker/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbsGoalButton extends StatefulWidget {
  @override
  State createState() => new AbsGoalButtonState();

  late String sportType = "";

  AbsGoalButton(String typeOfSportPicked) {
    sportType = typeOfSportPicked;
  }
}

class AbsGoalButtonState extends State<AbsGoalButton> {
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
    dropDownValue = userViewModel.tempOverallGoals["Abs"]!;
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
            print(userViewModel.trainingModel.type + " ABS GOAL BUTTON");
            userViewModel.updateQuantityGoal(widget.sportType, dropDownValue);
          });
        });
  }
}
