import 'package:flutter/material.dart';

class DropDownScreen extends StatefulWidget {
  @override
  State createState() => new DropDownScreenState();
}

class DropDownScreenState extends State<DropDownScreen> {
  List<String> options = <String>[
    'Sit-ups',
    'Push-ups',
    'Abs',
    'Lunges',
    
  ];
  String dropDownValue = 'Sit-ups';
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: dropDownValue,
      items: options.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        },
      ).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropDownValue = newValue!;
        });
      },
    );
  }
}
