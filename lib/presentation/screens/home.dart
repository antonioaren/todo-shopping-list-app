import 'package:english_words/src/word_pair.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_shopping_list_app/presentation/providers/word.dart';
import '../providers/counter.dart';
import '../widgets/global.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WordState wordState = context.watch<WordState>();
    CounterState counterState = context.watch<CounterState>();

    WordPair currentWord = wordState.getCurrent();
    int currentCounter = counterState.getCurrent();
    List<WordPair> favorites = wordState.getFavorites();

    // This lines it is just to get the actual theme. This contains styles, colors, etc.
    ThemeData theme = Theme.of(context);

    // Here we get some TextTheme that is defined in the theme, like displayMedium.
    // Then we copy the style, but with some modifications that we need to add.
    TextStyle style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    IconData icon;
    if (favorites.contains(currentWord)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Welcome to yout favorite shopping list!',
              style: style.copyWith(fontWeight: FontWeight.w200),
            ),
          ),
          Display(wordPair: currentWord),
          Text(
            'Counter: $currentCounter',
            style: theme.textTheme.headlineMedium,
          ),
          ElevatedButton.icon(
              onPressed: wordState.toggleFavorite,
              icon: Icon(icon),
              label: Text('Like')),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              textDirection: TextDirection.rtl,
              children: <Widget>[
                ElevatedButton(
                  onPressed: counterState.incrementCounter,
                  child: const Icon(Icons.add),
                ),
                ElevatedButton(
                  onPressed: wordState.getNextWord,
                  child: const Text('Another random word'),
                ),
                ElevatedButton(
                  onPressed: counterState.decrementCounter,
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
