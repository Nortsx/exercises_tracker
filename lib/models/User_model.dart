import 'dart:io';
import 'package:exercises_tracker/db/Database_provider.dart';
import 'package:exercises_tracker/models/training_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';

class UserModel {
  late String nickname;
  late bool isSigned;
  late bool isSoundPlayed;
  Image? profilePhoto;

  UserModel() {
    isSoundPlayed = true;
    isSigned = false;
    nickname = "";
  }

  void setNewImage(Image image) {
    profilePhoto = image;
  }

  Image? getCurrentImage() {
    return profilePhoto;
  }

  void setNewName(String nickname) {
    this.nickname = nickname;
  }

  String getNickname() {
    return nickname;
  }

  bool get isSignedUp {
    return isSigned;
  }

  set isSignedUp(bool value) {
    isSigned = value;
  }

  bool get isSoundEnabled {
    return isSoundPlayed;
  }

  set isSoundEnabled(bool value) {
    isSoundPlayed = value;
  }
}
