import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:exercises_tracker/db/Database_provider.dart';
import 'package:exercises_tracker/models/training_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../models/User_model.dart';
import 'dart:convert';

class UserViewModel extends ChangeNotifier {
  var userModel = UserModel();

  //magic number to figure out if goal was reached more than once per a day
  late int overWorked;

  late var trainingModel;

  //Map to store goals for all the types of sport
  final Map<String, int> tempOverallGoals = {};

  UserViewModel() {
    getUtilsInfo();
    if (!userModel.isSignedUp) {
      _setRandomNickname();
      insertInfoIntoDB();
    }
    overWorked = 0;
    notifyListeners();
  }

//generate random nickname if you're using the app for the first time
  void _setRandomNickname() {
    var randomInt = Random();
    int lowerBound = 65;
    int upperBound = 122;
    String randomNickName = '';
    for (int i = 0; i < (1 + randomInt.nextInt(6 - 1)); ++i) {
      randomNickName += String.fromCharCode(
          lowerBound + randomInt.nextInt(upperBound - lowerBound));
    }
    userModel.setNewName(randomNickName);
    notifyListeners();
  }

//increase amount of completed exercises, input's taken from input form in the main_screen
  void increaseAmountOfCompleted(String amount) {
    var dateTime = DateTime.now();
    int accomplishedAmount = int.parse(amount);
    trainingModel.increaseBy(accomplishedAmount);
    insertNewAccomplished(accomplishedAmount, dateTime.toIso8601String());
    print(amount); //debug-only

    if (userModel.isSoundPlayed) {
      if (trainingModel.getCurrentAmount() >= trainingModel.goalInQuantity) {
        overWorked++;
        if (overWorked == 1) {
          AudioCache audioPlayer = AudioCache();
          String audioAsset = "CompletedSound.wav";
          audioPlayer.play(audioAsset);
        }
      }
    }
    notifyListeners();
  }

  int getCurrentAmount() {
    return trainingModel.currentAmount;
  }

  int getGoalAmount() {
    return trainingModel.goalInQuantity;
  }

  String getTypeOfSport() {
    return trainingModel.type;
  }

//gather all the information required to properly run the app
  void getUtilsInfo() async {
    print("Creation of an object");
    trainingModel = TrainingModel();
    userModel.isSignedUp = await queryForNickname()!;
    queryForSound();
    queryForSportTypes();
    queryForGoals();
    fetchGoalsFromTable();
    updateLoginDateInTable();
    updateCurrentProgress();
    setNewProfilePhoto();
    notifyListeners();
  }

//Query for goals each time viewmodel's created, which result's gonna be presented in the progress bar and settings.
  void queryForGoals() async {
    Database db = await DatabaseProvider.instance.database;
    List<Map> result =
        await db.rawQuery("SELECT sport_type_id FROM Goals_info LIMIT 1");
    if (result!.isEmpty) {
      initializeGoalsTable();
    } else {
      Database db = await DatabaseProvider.instance.database;
      List<Map> resultQuantity = await db.rawQuery(
          "SELECT quantity_goal from Goals_info WHERE sport_type_id = (SELECT sport_type_id FROM Sport_types WHERE sport_type_name = ?)",
          [trainingModel.type]);
      trainingModel.goalInQuantity = resultQuantity[0]!.values.first;
      List<Map> resultMinutes = await db.rawQuery(
          "SELECT time_goal from Goals_info WHERE sport_type_id = (SELECT sport_type_id FROM Sport_types WHERE sport_type_name = ?)",
          ["Time estimated"]);
      trainingModel.goalInMinutes = resultMinutes[0]!.values.first;
    }
    print("QUERY FOR GOALS $trainingModel.goalInQuantity");
    notifyListeners();
  }

//Initialize required tables for the first time of using the app.
  void initializeGoalsTable() async {
    Database db = await DatabaseProvider.instance.database;
    final batch = db.batch();
    batch.execute(
        """INSERT INTO Goals_info (user_id, sport_type_id, quantity_goal) VALUES ((SELECT user_id FROM User_info LIMIT 1),
         (SELECT sport_type_id FROM Sport_types WHERE sport_type_name = ?), ?)""",
        ["Sit-ups", 100]);
    batch.execute(
        """INSERT INTO Goals_info (user_id, sport_type_id, quantity_goal) VALUES ((SELECT user_id FROM User_info LIMIT 1),
         (SELECT sport_type_id FROM Sport_types WHERE sport_type_name = ?), ?)""",
        ["Push-ups", 100]);
    batch.execute(
        """INSERT INTO Goals_info (user_id, sport_type_id, quantity_goal) VALUES ((SELECT user_id FROM User_info LIMIT 1),
         (SELECT sport_type_id FROM Sport_types WHERE sport_type_name = ?), ?)""",
        ["Abs", 100]);
    batch.execute(
        """INSERT INTO Goals_info (user_id, sport_type_id, quantity_goal) VALUES ((SELECT user_id FROM User_info LIMIT 1),
         (SELECT sport_type_id FROM Sport_types WHERE sport_type_name = ?), ?)""",
        ["Lunges", 100]);
    batch.execute(
        """INSERT INTO Goals_info (user_id, sport_type_id, time_goal) VALUES ((SELECT user_id FROM User_info LIMIT 1),
         (SELECT sport_type_id FROM Sport_types WHERE sport_type_name = ?), ?)""",
        ["Time estimated", 10]);
    batch.commit(noResult: true);
  }

//Get the first type of sport to be loaded at the startup of the application.
  void queryForSportTypes() async {
    Database db = await DatabaseProvider.instance.database;
    List<Map> result =
        await db.rawQuery("SELECT sport_type_name FROM Sport_types LIMIT 1");
    if (result!.isEmpty) {
      db.rawInsert(
          "INSERT INTO Sport_types (sport_type_name) VALUES (?), (?), (?), (?), (?)",
          ["Sit-ups", "Push-ups", "Abs", "Lunges", "Time estimated"]);
    } else {
      trainingModel.type = result[0]!.values.first;
    }
    notifyListeners();
    debugPrint(trainingModel.type + " QUERYFORSPORTTYPES");
  }

//Get boolean value represnted by either 0 or 1 to get to know wheter sound should be enabled or disabled.
  void queryForSound() async {
    Database db = await DatabaseProvider.instance.database;
    List<Map> result =
        await db.rawQuery("SELECT isSoundEnabled FROM User_info LIMIT 1");
    if (result[0].values.first == 1) {
      userModel.isSoundPlayed = true;
    } else {
      userModel.isSoundPlayed = false;
    }
    notifyListeners();
  }

//If you're using the app for more than once, it'll query the nickname stored in DB.
  Future<bool> queryForNickname() async {
    bool isSigneUp = false;
    Database db = await DatabaseProvider.instance.database;
    List<Map> result =
        await db.rawQuery("SELECT nickname from User_info LIMIT 1");
    await db.rawDelete("DELETE FROM User_info WHERE user_id != 1");
    if (result[0]!.isEmpty) {
      return isSigneUp;
    } else {
      userModel.nickname = result[0].values.first;
      isSigneUp = true;
      notifyListeners();
      return isSigneUp;
    }
  }

//Inserts random nickname if you're using the app for the first time.
  void insertInfoIntoDB() async {
    var nickname = userModel.getNickname();
    String now = new DateTime.now().toIso8601String();
    // var date = DateTime(now.year, now.month, now.day);
    Database db = await DatabaseProvider.instance.database;
    db.rawInsert(
        'INSERT INTO User_info(nickname, last_login_date) VALUES(?, ?)',
        [nickname, now]);
    notifyListeners();
  }

//Each time you open the app, it updates last time of logging in to later update progress values.
  void updateLoginDateInTable() async {
    String now = new DateTime.now().toIso8601String();
    Database db = await DatabaseProvider.instance.database;
    db.rawUpdate("UPDATE User_info SET last_login_date = ? WHERE nickname = ?",
        [now, userModel.nickname]);
  }

//Sets new nickname, which value is taken from a special form in the settings_screen.
  void setNewNickname(String newNickname) async {
    Database db = await DatabaseProvider.instance.database;
    db.rawUpdate("UPDATE User_info SET nickname = ? WHERE nickname = ?",
        [newNickname, userModel.nickname]);
    userModel.nickname = newNickname;
    print(newNickname + " setNewNickname");

    notifyListeners();
  }

//Changes sound feature and sets it to either enabled or disabled.
  void changeButtonState(bool currentState) async {
    Database db = await DatabaseProvider.instance.database;
    db.rawUpdate("UPDATE User_info SET isSoundEnabled = ? WHERE nickname = ?",
        [currentState == true ? 1 : 0, userModel.nickname]);
    userModel.isSoundPlayed = currentState;
    notifyListeners();
  }

//Sets updated amount of accomplished progress in the DB.
  void updateQuantityGoal(String type, int amount) async {
    Database db = await DatabaseProvider.instance.database;
    db.rawUpdate(
        "UPDATE Goals_info SET quantity_goal = ? WHERE sport_type_id = (SELECT sport_type_id FROM Sport_types WHERE sport_type_name = ?)",
        [amount, type]);
    trainingModel.goalInQuantity = amount;
    trainingModel.type = type;
    fetchGoalsFromTable();
    notifyListeners();
  }

//Updates current type of sport and gather all the needed information for its propep representation.
  void updateType(String newType) {
    trainingModel.type = newType;
    updateGoal(newType);
    updateCurrentProgress();
    notifyListeners();
  }

//Gets progress whic's already made during current day. Next day'll start with 0 value.
  void updateCurrentProgress() async {
    String currentDate = new DateTime.now().toIso8601String().substring(0, 10);
    print(currentDate);
    Database db = await DatabaseProvider.instance.database;
    List<Map> result = await db
        .rawQuery("""SELECT SUM(current_quantity_progress) FROM Sports_info
    WHERE sport_type_id = (SELECT sport_type_id FROM Sport_types WHERE sport_type_name = ?) AND inserting_date LIKE ?
    """, [trainingModel.type, '$currentDate%']);
    print(result);
    if (result[0].values.first == null) {
      trainingModel.currentAmount = 0;
      trainingModel.currentAmountForProgressBar = 0;
    } else {
      trainingModel.setProgresses(result[0].values.first);
    }
    if (trainingModel.currentAmount > trainingModel.goalInQuantity) {
      overWorked = 2;
    } else {
      overWorked = 0;
    }
    print(trainingModel.currentAmount);
    print("======================================");
    print(trainingModel.currentAmountForProgressBar);
    notifyListeners();
  }

//Gets goal according to sport's type, which's gonna be presented in the progress bar.
  void updateGoal(String newType) async {
    Database db = await DatabaseProvider.instance.database;
    List<Map> result = [];
    result = await db.rawQuery(
        "SELECT quantity_goal from Goals_info WHERE sport_type_id = (SELECT sport_type_id FROM Sport_types WHERE sport_type_name = ?)",
        [newType]);
    trainingModel.goalInQuantity = result[0]!.values.first;
    debugPrint(trainingModel.goalInQuantity.toString() + " UPDATEGOAL");
    notifyListeners();
  }

//Gets all the goals of different kinds of sport which're going to be stored in the Map structure to be available later at different screens.
  void fetchGoalsFromTable() async {
    Database db = await DatabaseProvider.instance.database;

    List<Map> timeResult = await db.rawQuery(
      "SELECT time_goal FROM Goals_info WHERE quantity_goal IS NULL",
    );
    //debugPrint(result[0].values.first! + " fetchGoalsFromTable");
    if (timeResult.isNotEmpty) {
      tempOverallGoals.putIfAbsent(
          "Time estiated", () => timeResult[0].values.first);
      //tempOverallGoals["Time estimated"] = timeResult[0].values.first;
      print("FETCHFROMTABLE");
      print(tempOverallGoals.values.first);
      print(tempOverallGoals.keys.first);
    }
    List<Map> quantityResult = await db.rawQuery(
      "SELECT quantity_goal, sport_type_name FROM Goals_info INNER JOIN Sport_types ON Goals_info.sport_type_id = Sport_types.sport_type_id",
    );
    print(quantityResult);
    for (int i = 0; i < quantityResult.length - 1; ++i) {
      tempOverallGoals[quantityResult[i]!.values.last] =
          quantityResult[i]!.values.first;
    }
    //print(quantityResult);
    notifyListeners();
  }

  int getGoalFromTempStorage(String typeOfSport) {
    return tempOverallGoals[typeOfSport]!;
  }

//Inserts amount of completed exercices with the time they've been completed at to the Sports_info table to later fetch them.
  void insertNewAccomplished(int amount, String time) async {
    Database db = await DatabaseProvider.instance.database;
    if (trainingModel.type != "Time estimated") {
      db.rawInsert("""
INSERT INTO Sports_info (user_id, current_quantity_progress, inserting_date, sport_type_id)
VALUES
(
  (SELECT user_id FROM User_info WHERE nickname = ?),
  ?,
  ?,
  (SELECT sport_type_id FROM Sport_types WHERE sport_type_name = ?)
)
""", [
        userModel.nickname,
        trainingModel.currentAmount,
        time,
        trainingModel.type
      ]);
    } else {
      db.rawInsert("""
INSERT INTO Sports_info (user_id, current_time_progress, inserting_date, sport_type_id)
VALUES
(
  (SELECT user_id FROM User_info WHERE nickname = ?),
  ?,
  ?,
  (SELECT sport_type_id FROM Sport_types WHERE sport_type_name = ?)
)
""", [
        userModel.nickname,
        trainingModel.currentAmount,
        time,
        trainingModel.type
      ]);
    }
    notifyListeners();
  }

//Sets new chosen image from gallery as a new profile photo in DB which's later gonna be shown in screens.
  void updateProfilePhoto(File? img) async {
    Database db = await DatabaseProvider.instance.database;
    List<int> bytes = await img!.readAsBytes();
    db.rawUpdate(
        "UPDATE User_info SET profile_photo = ? WHERE user_id = (SELECT user_id FROM User_info WHERE nickname = ?)",
        [bytes, userModel.nickname]);
    setNewProfilePhoto();
    notifyListeners();
  }

//Queries image from DB and sets it as the profile photo of the current user.
  void setNewProfilePhoto() async {
    Database db = await DatabaseProvider.instance.database;
    List<Map> result = await db.rawQuery(
        "SELECT profile_photo FROM User_info WHERE nickname = ?",
        [userModel.nickname]);
    if (result[0].values.first == null) {
      return;
    } else {
      userModel.profilePhoto =
          Image.memory(Uint8List.fromList(result[0].values.first));
    }
    notifyListeners();
  }
}
