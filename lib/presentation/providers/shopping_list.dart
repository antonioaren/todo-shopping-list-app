import 'package:flutter/material.dart';

class ShoppingListState extends ChangeNotifier {
  List<String> items = [];

  List<String> getCurrent() {
    return items;
  }

  void addItem(String item) {
    items.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    items.removeAt(index);
    notifyListeners();
  }
}
