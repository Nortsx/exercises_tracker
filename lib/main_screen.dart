import 'package:exercises_tracker/components/MainMenuProfilePhoto_builder.dart';
import 'package:exercises_tracker/components/mainNicknameBar_builder.dart';
import 'package:exercises_tracker/components/progressBar_builder.dart';
import 'package:exercises_tracker/models/training_model.dart';
import 'package:exercises_tracker/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:exercises_tracker/components/dropdownScreen_builder.dart';
import 'package:exercises_tracker/components/inputScreen_builder.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(248, 242, 242, 100),
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
                      fit: BoxFit.fill)),
            ),
          ),
        ),
        Center(
          child: Align(
              alignment: Alignment(0, -1.5),
              child: Container(
                height: 55.h,
                alignment: Alignment.topCenter,
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    image: DecorationImage(
                        image: AssetImage("assets/MainUpperBackground.png"),
                        fit: BoxFit.fitWidth)),
              )),
        ),
        Center(child: _buildNavBar()),
        Center(child: _buildTimer()),
        SafeArea(child: _buildTrainingField()),
        SafeArea(
          child: Center(child: _buildUserField(context)),
        ),
      ]),
    );
  }

  Widget _buildTrainingField() {
    return Align(
      alignment: Alignment(0.0, -0.7),
      child: Container(
        width: 600,
        height: 35.h,
        child: Column(
          children: [
            Align(
              alignment: Alignment(0.0, -0.6),
              child: Text(
                "Quantity estimated",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Align(child: ProgressBar()),
            SizedBox(
              height: 30,
            ),
            Align(
                child: Container(
              width: 250,
              height: 48,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/RectangleDropdown.png"),
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 2,
                  ),
                  Align(
                    alignment: Alignment(0, -0.1),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: DropDownScreen(),
                    ),
                  ),
                  Align(
                    alignment: Alignment(1, 1),
                    child: SizedBox(
                      height: 250,
                      width: 120,
                      child: InputScreen(),
                    ),
                  ),
                ],
              ),
            )),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildUserField(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: 30.h,
          width: double.infinity,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            alignment: Alignment(0.5, -0.9),
                            image: AssetImage("assets/RectangleName.png")))),
              ),
              MainNicknameBar(),
              Align(
                  alignment: Alignment(0.88, -0.9),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsScreen(),
                          ),
                        );
                      },
                      child: MainMenuProfilePhoto())),
            ],
          ),
        ));
  }

  Widget _buildTimer() {
    return Align(
      alignment: Alignment(0, 0.55),
      child: Container(
        width: double.infinity,
        height: 36.h,
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Time estimated",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 55,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: CircularPercentIndicator(
                  radius: 90,
                  percent: 50 / 100,
                  progressColor: Color.fromARGB(181, 126, 242, 100),
                  center: new Text("Timer",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildNavBar() {
    return Align(
        alignment: Alignment(0, 0.9),
        child: Container(
          height: 52,
          width: 269,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/MenuRectangle.png"))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/MainMenuIcon.png"),
                  alignment: Alignment.centerLeft,
                )),
              ),
              Container(
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/RecordsIcon.png"),
                        alignment: Alignment.center)),
              ),
              Container(
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/LeaderboardIcon.png"),
                        alignment: Alignment.centerRight)),
              ),
            ],
          ),
        ));
  }
}
