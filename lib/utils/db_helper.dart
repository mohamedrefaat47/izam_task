import 'dart:io';
import 'package:izam_task/models/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper; // Singleton DatabaseHelper
  static Database? _database; // Singleton Database

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper
  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper
        ._createInstance(); // This is executed only once, singleton object
    return _databaseHelper!;
  }
  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = p.join(directory.toString(), 'izam.db');
    Database database =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return database;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "create table users(id integer primary key autoincrement,email TEXT,password TEXT,numOfLogins INTEGER)");
  }

  Future<int> insertuser(User user) async {
    Database dB = await database;

    return dB.insert("users", user.toMap());
  }

  Future<int> updateUser(User user) async {
    Database dB = await database;
    return await dB
        .update("users", user.toMap(), where: "id = ?", whereArgs: [user.id]);
  }

  Future<List<Map<String, dynamic>>> getUsersMapList() async {
    Database dB = await database;
    return dB.query("users");
  }

  Future<List<User>> getUsersList() async {
    // Get 'Map List' from database
    var usersMapList = await getUsersMapList();
    // Count the number of map entries in db table
    int count = usersMapList.length;
    List<User> usersList = <User>[];
    // For loop to create a 'Users List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      usersList.add(User.fromMapObject(usersMapList[i]));
    }
    return usersList;
  }

  Future<User?> queryUser(String email) async {
    Database db = await database;
    List<Map<String, dynamic>> maps =
        await db.query("users", where: "email = ?", whereArgs: [email]);
    if (maps.isNotEmpty) return User.fromMapObject(maps.first);
    return null;
  }
}
