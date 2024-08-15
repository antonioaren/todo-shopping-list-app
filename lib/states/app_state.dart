import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  var current = WordPair.random();
  var favorites = <WordPair>[]; // This is how a list is manage in Flutter.

  int counter = 0;

  void incrementCounter() {
    counter++;
    notifyListeners();
  }

  void decrementCounter() {
    counter--;
    notifyListeners();
  }

  void getNext() {
    current = WordPair.random();
    // This notify all elements that watch this state.
    notifyListeners();
  }

  void toggleFavorite() {
    // This is how we can verify if a word is in the list.(Similar to javascript)
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}
