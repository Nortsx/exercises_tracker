import 'package:exercises_tracker/components/ProfilePhotoPicker_builder.dart';
import 'package:exercises_tracker/components/SitupsGoalButton_builder.dart';
import 'package:exercises_tracker/components/SettingsNicknameBar_builder.dart';
import 'package:exercises_tracker/components/SwitchButton_builder.dart';
import 'package:exercises_tracker/components/goalChangerButton_builder.dart';
import 'package:exercises_tracker/components/nicknameChanger_builder.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:exercises_tracker/main_screen.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          Center(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 800,
                alignment: Alignment.bottomCenter,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/MainLowerBackground.png"),
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.fill),
                ),
              ),
            ),
          ),
          Center(
            child: Align(
                alignment: Alignment(0, -1.5),
                child: Container(
                  height: 50.h,
                  alignment: Alignment.topCenter,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      image: DecorationImage(
                          image: AssetImage("assets/MainUpperBackground.png"),
                          fit: BoxFit.fitWidth),
                      border: Border.all(
                        color: Color.fromARGB(100, 151, 151, 151),
                        width: 2,
                      )),
                )),
          ),
          Center(
            child: _buildProfileBar(context),
          ),
          Center(
            child: _buildSettingsBar(),
          ),
          SafeArea(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: Text("Version 0.0.0"),
          ))
        ]));
  }

  Widget _buildProfileBar(BuildContext context) {
    return SafeArea(
        child: Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.infinity,
        height: 50.h,
        child: Stack(children: [
          Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/ExitIcon.png"))),
                  ))),
          Align(
              alignment: Alignment(0.0, -0.75),
              child: Center(
                child: Column(children: [
                  ProfilePhotoPicker(),
                  SizedBox(height: 35),
                  SettingsNicknameBar()
                ]),
              ))
        ]),
      ),
    ));
  }

  Widget _buildSettingsBar() {
    return SafeArea(
        child: Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            height: 250,
          ),
          buildGoalsBar(),
          buildNicknameBar(),
          buildSoundBar()
        ],
      ),
    ));
  }

  Widget buildGoalsBar() {
    return Container(
      width: double.infinity,
      height: 10.h,
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Change daily goals",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 18),
            ),
          ),
          SizedBox(
            width: 110,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GoalChangerScreen(),
          )
        ],
      ),
    );
  }

  Widget buildNicknameBar() {
    return Container(
      width: double.infinity,
      height: 10.h,
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Change nickname",
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          SizedBox(
            width: 120,
          ),
          Expanded(child: NicknameChanger())
        ],
      ),
    );
  }

  Widget buildSoundBar() {
    return Container(
      width: double.infinity,
      height: 10.h,
      child: Row(children: [
        SizedBox(width: 55),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Sound",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 18),
          ),
        ),
        SizedBox(
          width: 200,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: SwitchButton(),
        )
      ]),
    );
  }
}
