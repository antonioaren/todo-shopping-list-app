import 'package:flutter/material.dart';

class ShoppingListItem {
  final String name;
  final int index;
  late bool isDone;

  ShoppingListItem({
    required this.index,
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
    shoppingListItems.add(ShoppingListItem(index: index, name: item));
    notifyListeners();
  }

  void toggleItem(int index) {
    final item =
        shoppingListItems.firstWhere((element) => element.index == index);
    item.isDone = !item.isDone;
    notifyListeners();
  }

  void removeItem(int index) {
    shoppingListItems.removeWhere((element) => element.index == index);
    notifyListeners();
  }
}
