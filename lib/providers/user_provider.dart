import 'package:flutter/material.dart';
import 'package:izam_task/models/user.dart';
import 'package:izam_task/utils/db_helper.dart';
import 'package:collection/collection.dart';

class UserProvider with ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  List<User> usersList = [];

  Future<void> initializeProvider() async {
    await _databaseHelper.initializeDatabase();
    _initializeUsers();
    notifyListeners();
  }

  Future<void> _initializeUsers() async {
    usersList = await _databaseHelper.getUsersList();
  }

  Future<void> addnewUser(User user) async {
    usersList.add(user);
    await _databaseHelper.insertuser(user);
    notifyListeners();
  }

  Future<void> updateUser(User user) async {
    int index = usersList.indexWhere((element) => element.email == user.email);
    usersList[index] = user;
    await _databaseHelper.updateUser(user);
    notifyListeners();
  }

  User? searchUsers(String email) {
    return usersList.firstWhereOrNull((element) => element.email == email);
  }
}
