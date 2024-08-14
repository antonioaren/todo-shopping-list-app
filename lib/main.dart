import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class AppState extends ChangeNotifier {
  var current = WordPair.random();
  var favorites = <WordPair>[]; // This is how a list is manage in Flutter.

  int counter = 0;

  void incrementCounter() {
    counter++;
    notifyListeners();
  }

  void decrementCounter() {
    counter--;
    notifyListeners();
  }

  void getNext() {
    current = WordPair.random();
    // This notify all elements that watch this state.
    notifyListeners();
  }

  void toggleFavorite() {
    // This is how we can verify if a word is in the list.(Similar to javascript)
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'Welcome to yout favorite shopping list!',
          ),
          Display(wordPair: pair),
          Text(
            'Counter: ${appState.counter}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          ElevatedButton.icon(
              onPressed: appState.toggleFavorite,
              icon: Icon(icon),
              label: Text('Like')),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              textDirection: TextDirection.rtl,
              children: <Widget>[
                ElevatedButton(
                  onPressed: appState.incrementCounter,
                  child: const Icon(Icons.add),
                ),
                ElevatedButton(
                  onPressed: appState.getNext,
                  child: const Text('Another random word'),
                ),
                ElevatedButton(
                  onPressed: appState.decrementCounter,
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var favorites = appState.favorites;
    var pair = appState.current;

    return ListView(
      children: <Widget>[
        Text('All favorites'),
        Text(favorites.length.toString()),
        for (var fav in favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
          )
      ],
    );
  }
}

class Display extends StatelessWidget {
  const Display({
    super.key,
    required this.wordPair,
  });

  final WordPair wordPair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
        color: theme.colorScheme.inversePrimary,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Text(
            wordPair.asPascalCase,
            style: style,
            semanticsLabel: "${wordPair.first}  ${wordPair.second}",
          ),
        ));
  }
}
