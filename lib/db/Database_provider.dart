import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static final DatabaseProvider instance = DatabaseProvider._init();

  static Database? _database;

  DatabaseProvider._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('FitnessInfo.db');
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);

    debugPrint(path);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE IF NOT EXISTS User_info(
  user_id INTEGER PRIMARY KEY AUTOINCREMENT,
  nickname VARCHAR(200),
  isSoundEnabled INTEGER DEFAULT 1,
  last_login_date TEXT,
  profile_photo BLOB
);
''');

    await db.execute('''CREATE TABLE IF NOT EXISTS Sports_info(
  user_id INTEGER NOT NULL,
  current_quantity_progress INTEGER,
  current_time_progress INTEGER,
  inserting_date TEXT,
  sport_type_id INTEGER NOT NULL,
  FOREIGN KEY(sport_type_id) REFERENCES Sport_types(sport_type_id),
  FOREIGN KEY(user_id) REFERENCES User_info(user_id)
);''');
    await db.execute('''CREATE TABLE IF NOT EXISTS Sport_types(
  sport_type_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  sport_type_name VARCHAR(200) NOT NULL,
  UNIQUE(sport_type_name)
);''');

    db.execute('''CREATE TABLE IF NOT EXISTS Goals_info(
  user_id INTEGER NOT NULL,
  sport_type_id INTEGER NOT NULL,
  quantity_goal INTEGER,
  time_goal INTEGER,
  FOREIGN KEY(user_id) REFERENCES User_info(user_id)
);''');
  }

  Future close() async {
    final db = await instance.database;
    _database = null;

    db.close();
  }
}
