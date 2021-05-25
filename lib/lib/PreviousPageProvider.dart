import 'package:flutter/material.dart';

class PreviousPageProvider with ChangeNotifier {
  String previousPageName;

  visit(String pageName) {
    previousPageName = pageName;
    notifyListeners();
  }
}
