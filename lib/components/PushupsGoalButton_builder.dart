import 'package:exercises_tracker/components/GoalButtonChanger_builder.dart';
import 'package:exercises_tracker/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PushupsGoalButton extends GoalButton {
  PushupsGoalButton(String typeOfSportPicked) : super(typeOfSportPicked);
}

class PushupsGoalButtonState extends GoalButtonChangerState<PushupsGoalButton> {
}
