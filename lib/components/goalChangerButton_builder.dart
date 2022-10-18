import 'package:exercises_tracker/components/AbsGoalButton_builder.dart';
import 'package:exercises_tracker/components/GoalInMinutesButton_builder.dart';
import 'package:exercises_tracker/components/LungesGoalButon_builder.dart';
import 'package:exercises_tracker/components/PushupsGoalButton_builder.dart';
import 'package:exercises_tracker/components/SitupsGoalButton_builder.dart';
import 'package:exercises_tracker/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'GoalButtonChanger_builder.dart';

class GoalChangerScreen extends StatefulWidget {
  @override
  State createState() => new GoalChangerScreenState();
}

class GoalChangerScreenState extends State<GoalChangerScreen> {
  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = context.watch<UserViewModel>();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
      onPressed: () => _onButtonPressed(),
      child: Text(
        "Change",
        style:
            TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _onButtonPressed() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        context: context,
        builder: (context) {
          return Container(
            child: _buildBottomChangerMenu(),
          );
        });
  }

  Widget _buildSitupsGoalChangerButton() {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Sit-ups",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
          ),
        ),
        SizedBox(
          width: 265,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: SitupsGoalButton("Sit-ups"),
        )
      ],
    );
  }

  Widget _buildPushupsGoalChangerButton() {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Push-ups",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
          ),
        ),
        SizedBox(
          width: 250,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: PushupsGoalButton("Push-ups"),
        )
      ],
    );
  }

  Widget _buildAbsGoalChangerButton() {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Abs",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
          ),
        ),
        SizedBox(
          width: 287,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: AbsGoalButton("Abs"),
        )
      ],
    );
  }

  Widget _buildLungesGoalChangerButton() {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Lunges",
            style: TextStyle(
                fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: 264,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: LungesGoalButton("Lunges"),
        )
      ],
    );
  }

  Widget _buildTimeGoalChangerButton() {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Time estimated",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
          ),
        ),
        SizedBox(
          width: 217,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GoalInMinutesButton(),
        )
      ],
    );
  }

  Widget _buildBottomChangerMenu() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        _buildSitupsGoalChangerButton(),
        SizedBox(
          height: 10,
        ),
        _buildPushupsGoalChangerButton(),
        SizedBox(
          height: 10,
        ),
        _buildAbsGoalChangerButton(),
        SizedBox(
          height: 10,
        ),
        _buildLungesGoalChangerButton(),
        SizedBox(
          height: 10,
        ),
        _buildTimeGoalChangerButton(),
      ],
    );
  }
}
