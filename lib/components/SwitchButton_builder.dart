import 'package:exercises_tracker/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwitchButton extends StatefulWidget {
  @override
  State createState() => new SwitchButtonState();
}

class SwitchButtonState extends State<SwitchButton> {
  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = context.watch<UserViewModel>();
    return Transform.scale(
        scale: 1,
        child: Switch.adaptive(
          value: userViewModel.userModel.isSoundPlayed,
          activeColor: Colors.greenAccent,
          onChanged: ((currentMode) => setState(() {
                userViewModel.changeButtonState(currentMode);
                userViewModel.userModel.isSoundPlayed = currentMode;
              })),
        ));
  }
}
