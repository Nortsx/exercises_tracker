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
    //int currentAmount = trainingsViewModel.getCurrentAmount();
    //int goal = trainingsViewModel.getGoalAmount(); //TODO I am not sure we can get model values without forwarding it through the main
    int currentAmount = 0;
    int goal = 0;
    return CircularPercentIndicator(
      radius: 45,
      percent:
      currentAmount / 100,
      progressColor: Color.fromARGB(181, 126, 242, 100),
      center: new Text(
        "$currentAmount/$goal",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
