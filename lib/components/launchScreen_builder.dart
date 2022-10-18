import 'dart:async';

import 'package:exercises_tracker/main_screen.dart';
import 'package:flutter/material.dart';

class LaunchScreen extends StatefulWidget {
  @override
  LaunchScreenState createState() => LaunchScreenState();
}

class LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 1),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/MainLowerBackground.png"),
              alignment: Alignment.bottomCenter,
              fit: BoxFit.fill)),
      child: const Align(
        alignment: Alignment.center,
        child: Text(
          "IT-спортсмены prod.",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              decoration: TextDecoration.none),
        ),
      ),
    );
  }
}
