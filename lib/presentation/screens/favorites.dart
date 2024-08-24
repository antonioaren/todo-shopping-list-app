import 'package:english_words/src/word_pair.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/word.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WordState wordState = context.watch<WordState>();
    List<WordPair> favorites = wordState.getFavorites();

    return ListView(
      children: <Widget>[
        Text('All favorites'),
        Text(favorites.length.toString()),
        for (WordPair fav in favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(fav.asLowerCase),
          )
      ],
    );
  }
}
