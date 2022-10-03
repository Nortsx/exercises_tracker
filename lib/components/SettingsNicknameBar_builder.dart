import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/user_view_model.dart';

class SettingsNicknameBar extends StatefulWidget {
  @override
  State createState() => new SettingsNicknameBarState();
}

class SettingsNicknameBarState extends State<SettingsNicknameBar> {
  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = context.watch<UserViewModel>();
    String nickname = userViewModel.userModel.nickname;
    print(userViewModel.userModel.nickname + " SettingsNicknameBarState");
    return Container(
      alignment: Alignment.center,
      width: 300,
      height: 40,
      child: Text(
        nickname,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontStyle: FontStyle.italic),
      ),
    );
  }
}
