import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../states/app_state.dart';
import './screens/favorites.dart';
import './screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: const MyHomePage(
          title: 'Lista de la compra',
        ),
      ),
    );
  }
}

// ...

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _selectedIndex = 0;

  void _setIndexSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool _isMenuLabelsShowUp(double width) {
    return width >= 600;
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomePage(),
      FavoritePage(),
    ];

    Widget page = pages.elementAt(_selectedIndex);

    // This is a widget that gives us the constrains of the parent widget. We can make things responsive with this.
    return LayoutBuilder(builder: (context, constrains) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              // This is a widget that makes sure that the content is not behind the status bar or notch.
              child: NavigationRail(
                  extended: _isMenuLabelsShowUp(constrains.maxWidth),
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),
                  ],
                  selectedIndex:
                      _selectedIndex, // This is the default selected index
                  onDestinationSelected: _setIndexSelected),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}
