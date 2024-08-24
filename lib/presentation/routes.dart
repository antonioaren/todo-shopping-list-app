import 'package:flutter/material.dart';
import 'package:todo_shopping_list_app/presentation/screens/todo_list.dart';
import 'screens/favorites.dart';
import 'screens/home.dart';

// Way to store the page and the destination in a single object.
// We make objects using class.

class PageDestination {
  final Widget page;
  final NavigationRailDestination destination;

  PageDestination({
    required this.page,
    required this.destination,
  });
}

class Routes {
  static final List<PageDestination> pageDestinations = [
    PageDestination(
      page: HomePage(),
      destination: NavigationRailDestination(
        icon: Icon(Icons.home),
        label: Text('Home'),
      ),
    ),
    PageDestination(
      page: FavoritePage(),
      destination: NavigationRailDestination(
        icon: Icon(Icons.favorite),
        label: Text('Favorites'),
      ),
    ),
    PageDestination(
      page: TodoList(),
      destination: NavigationRailDestination(
        icon: Icon(Icons.list),
        label: Text('Shopping List'),
      ),
    ),
  ];
}
