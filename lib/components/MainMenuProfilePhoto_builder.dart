import 'package:exercises_tracker/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainMenuProfilePhoto extends StatefulWidget {
  @override
  State createState() => new MainMenuProfilePhotoState();
}

class MainMenuProfilePhotoState extends State<MainMenuProfilePhoto> {
  @override
  void initState() {
    super.initState();
  }

  Image? imageForAvatar;
  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = context.watch<UserViewModel>();
    imageForAvatar = userViewModel.userModel.getCurrentImage();
    return Container(
        width: 45,
        decoration: BoxDecoration(
            image: DecorationImage(
                alignment: Alignment(-0.2, -0.89),
                image: AssetImage("assets/UserAvatarIcon.png"))),
        child: Align(
          alignment: Alignment(-0.2, -1.21),
          child: imageForAvatar == null
              ? Text("")
              : CircleAvatar(
                  radius: 50,
                  backgroundImage: imageForAvatar!.image,
                ),
        ));
  }
}
