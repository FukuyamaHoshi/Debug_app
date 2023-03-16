import 'package:flutter/material.dart';

class QuestionModel with ChangeNotifier {
  int count = 0; // テストカウンター

  void increment() {
    count++;
    print(count);
    notifyListeners();
  }
}
