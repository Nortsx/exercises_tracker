import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/user_view_model.dart';

class DropDownScreen extends StatefulWidget {
  @override
  State createState() => new DropDownScreenState();
}

class DropDownScreenState extends State<DropDownScreen> {
  @override
  void initState() {
    super.initState();
  }

  List<String> options = <String>[
    'Sit-ups',
    'Push-ups',
    'Abs',
    'Lunges',
  ];
  late String dropDownValue;
  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = context.watch<UserViewModel>();
    dropDownValue = userViewModel.getTypeOfSport();
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
          userViewModel.updateType(newValue!);
          dropDownValue = newValue;
          debugPrint(userViewModel.trainingModel.type + " DROPDOWNVALUE");
        });
      },
    );
  }
}
