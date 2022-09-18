import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:exercises_tracker/models/training_model.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

import 'package:flutter/services.dart';

class TrainingsViewModel extends ChangeNotifier {
  var trainingModel = TrainingModel();
  int overWorked = 0;

  void increaseAmountOfCompleted(String amount) {
    var dateTime = DateTime.now();
    trainingModel.increaseBy(int.parse(amount), dateTime);
    print(amount); //debug-only

    if (getCurrentAmount() >= trainingModel.goalInQuantity) {
      overWorked++;
      if (overWorked == 1) {
        AudioCache audioPlayer = AudioCache();
        String audioAsset = "CompletedSound.wav";
        audioPlayer.play(audioAsset);
      }
    }

    notifyListeners();
  }

  int getCurrentAmount() {
    return trainingModel.currentAmount;
  }

  int getGoalAmount() {
    return trainingModel.goalInQuantity;
  }
}
