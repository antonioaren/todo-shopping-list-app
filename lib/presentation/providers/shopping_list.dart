import 'package:flutter/material.dart';

class ShoppingListItem {
  final String name;
  final int id;
  late bool isDone;

  ShoppingListItem({
    required this.id,
    required this.name,
    this.isDone = false,
  });
}

class ShoppingListState extends ChangeNotifier {
  List<ShoppingListItem> shoppingListItems = [];

  List<ShoppingListItem> getCurrent() {
    return shoppingListItems;
  }

  void addItem(String item) {
    final index = shoppingListItems.length;
    shoppingListItems.add(ShoppingListItem(id: index, name: item));
    notifyListeners();
  }

  void toggleItem(int id) {
    final item = shoppingListItems.firstWhere((element) => element.id == id);
    item.isDone = !item.isDone;
    notifyListeners();
  }

  void removeItem(int id) {
    shoppingListItems.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
