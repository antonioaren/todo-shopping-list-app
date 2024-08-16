import 'package:flutter/material.dart';

class CounterState extends ChangeNotifier {
  int counter = 0;

  int getCurrent() {
    return counter;
  }

  void incrementCounter() {
    counter++;
    notifyListeners();
  }

  void decrementCounter() {
    counter--;
    notifyListeners();
  }
}
