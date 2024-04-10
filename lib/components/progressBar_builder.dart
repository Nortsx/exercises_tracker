import 'dart:convert';

import 'package:exercises_tracker/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class ProgressBar extends StatefulWidget {
  @override
  State createState() => new ProgressBarState();
}

class ProgressBarState extends State<ProgressBar> {
  @override
  void initState() {
    super.initState();
  }

  late int goal;
  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = context.watch<UserViewModel>();
    int currentAmount = userViewModel.trainingModel.getCurrentAmount();
    int tempAmount;
    if (currentAmount > userViewModel.trainingModel.goalInQuantity) {
      tempAmount = userViewModel.trainingModel.goalInQuantity;
    } else {
      tempAmount = currentAmount;
    }
    //print("PROGRESSBARSTATE $currentAmountForProgressBar");
    int goal = userViewModel
        .getGoalAmount(); //TODO I am not sure we can get model values without forwarding it through the main
    //getValueFromFuture(userViewModel);
    return CircularPercentIndicator(
      radius: 45,
      percent: tempAmount / goal,
      progressColor: Color.fromARGB(181, 126, 242, 100),
      center: new Text(
        "$currentAmount/$goal",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
