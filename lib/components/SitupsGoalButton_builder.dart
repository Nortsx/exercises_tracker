import 'package:exercises_tracker/components/GoalButtonChanger_builder.dart';
import 'package:exercises_tracker/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SitupsGoalButton extends GoalButton {
  SitupsGoalButton(String typeOfSportPicked) : super(typeOfSportPicked);
}

class SitupsGoalButtonState extends GoalButtonChangerState<SitupsGoalButton> {}
