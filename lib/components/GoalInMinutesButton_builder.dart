import 'dart:ffi';

import 'package:flutter/material.dart';

class GoalInMinutesButton extends StatefulWidget {
  @override
  State createState() => new GoalInMinutesButtonState();
}

class GoalInMinutesButtonState extends State<GoalInMinutesButton> {
  List<int> minutesToBeCompleted = <int>[
    10,
    20,
    30,
    40,
    50,
  ];

  int dropDownValue = 10;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: dropDownValue,
        items: minutesToBeCompleted.map<DropdownMenuItem<int>>(
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
          });
        });
  }
}
