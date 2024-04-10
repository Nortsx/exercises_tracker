import 'package:exercises_tracker/components/GoalButtonChanger_builder.dart';
import 'package:exercises_tracker/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbsGoalButton extends GoalButton {
  @override
  State createState() => new AbsGoalButtonState();

  AbsGoalButton(String typeOfSportPicked) : super(typeOfSportPicked);
}

class AbsGoalButtonState extends GoalButtonChangerState<AbsGoalButton> {}
