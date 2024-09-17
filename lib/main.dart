import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:todo_shopping_list_app/presentation/providers/word.dart';
import 'presentation/providers/counter.dart';
import 'presentation/providers/shopping_list.dart';
import 'presentation/widgets/side_menu.dart';

void main() {
  runApp(const ShoppingList());
}

class ShoppingList extends StatelessWidget {
  const ShoppingList({super.key});

  final String title = 'Shopping List';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<CounterState>(
            create: (BuildContext context) => CounterState()),
        ChangeNotifierProvider<WordState>(
            create: (BuildContext context) => WordState()),
        ChangeNotifierProvider<ShoppingListState>(
            create: (BuildContext context) => ShoppingListState()),
      ],
      child: MaterialApp(
        title: title,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: SideMenu(
          title: title,
        ),
      ),
    );
  }
}

// ...


