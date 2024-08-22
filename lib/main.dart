import 'package:flutter/material.dart';
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
      providers: [
        ChangeNotifierProvider(create: (context) => CounterState()),
        ChangeNotifierProvider(create: (context) => WordState()),
        ChangeNotifierProvider(create: (context) => ShoppingListState()),
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


