import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/user_view_model.dart';

class MainNicknameBar extends StatefulWidget {
  @override
  State createState() => new MainNicknameBarState();
}

class MainNicknameBarState extends State<MainNicknameBar> {
  @override
  void initState() {
    super.initState();
  }

  late String nickname;

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = context.watch<UserViewModel>();
    nickname = userViewModel.getUsername();
    print(userViewModel.userModel.nickname + " MainNicknameBarState");
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: 200,
        alignment: Alignment(-0.05, -0.8),
        child: new Text(
          nickname,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
