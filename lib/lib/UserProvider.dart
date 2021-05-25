import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String userId;

  void login(String userId) {
    this.userId = userId;
    notifyListeners();
  }
}