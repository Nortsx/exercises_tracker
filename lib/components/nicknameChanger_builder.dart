import 'package:exercises_tracker/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NicknameChanger extends StatefulWidget {
  @override
  State createState() => new NicknameChangerState();
}

class NicknameChangerState extends State<NicknameChanger> {
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = context.watch<UserViewModel>();
    String userNewNickname = "";
    return TextField(
        controller: _textController,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: userViewModel.userModel.nickname,
          border: InputBorder.none,
          suffixIcon: IconButton(
            onPressed: () {
              _textController.clear();
            },
            icon: const Icon(Icons.clear),
          ),
        ),
        onSubmitted: (String text) {
          setState(() {
            userNewNickname = text;
            userViewModel.setNewNickname(userNewNickname);
          });
          _textController.clear();
        },
        onChanged: (String text) {
          setState(() {});
        });
  }
}
