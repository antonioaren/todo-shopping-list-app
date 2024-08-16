import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/providers/app_state.dart';
import 'presentation/routes.dart';

void main() {
  runApp(const ShoppingList());
}

class ShoppingList extends StatelessWidget {
  const ShoppingList({super.key});

  final String title = 'Shopping List';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: title,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: Routes(
          title: title,
        ),
      ),
    );
  }
}

// ...


