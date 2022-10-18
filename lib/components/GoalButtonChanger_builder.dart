import 'package:exercises_tracker/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoalButton extends StatefulWidget {
  @override
  State createState() => new GoalButtonChangerState();

  late String sportType = "";

  GoalButton(String typeOfSportPicked) {
    sportType = typeOfSportPicked;
  }
}

class GoalButtonChangerState<StatefulWidget> extends State<GoalButton> {
  List<int> quantityToBeCompleted = <int>[
    100,
    150,
    200,
    250,
    300,
  ];
  late int dropDownValue;
  late String typeOfSport = widget.sportType;

  @override
  Widget build(BuildContext context) {
    var userViewModel = context.watch<UserViewModel>();
    dropDownValue = userViewModel.tempOverallGoals[typeOfSport]!;
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
            userViewModel.updateQuantityGoal(typeOfSport, dropDownValue);
          });
        });
  }
}
