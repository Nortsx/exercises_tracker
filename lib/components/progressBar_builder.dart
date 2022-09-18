import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:exercises_tracker/viewmodels/trainings_view_model.dart';

class ProgressBar extends StatefulWidget {
  @override
  State createState() => new ProgressBarState();
}

class ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    TrainingsViewModel trainingsViewModel = context.watch<TrainingsViewModel>();
    int currentAmount = trainingsViewModel.getCurrentAmount();
    int goal = trainingsViewModel.getGoalAmount();
    return CircularPercentIndicator(
      radius: 45,
      percent:
          trainingsViewModel.trainingModel.currentAmountForProgressBar / 100,
      progressColor: Color.fromARGB(181, 126, 242, 100),
      center: new Text(
        "$currentAmount/$goal",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
