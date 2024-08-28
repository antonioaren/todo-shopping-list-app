import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:todo_shopping_list_app/presentation/providers/word.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import 'firebase_options.dart';

import 'presentation/providers/counter.dart';
import 'presentation/providers/shopping_list.dart';
import 'presentation/widgets/side_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (FlutterErrorDetails errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

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


