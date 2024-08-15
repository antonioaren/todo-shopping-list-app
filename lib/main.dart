import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../states/app_state.dart';
import './routes.dart';

void main() {
  runApp(const ShoppingList());
}

class ShoppingList extends StatelessWidget {
  const ShoppingList({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Shopping List',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: const Routes(
          title: 'Lista de la compra',
        ),
      ),
    );
  }
}

// ...


