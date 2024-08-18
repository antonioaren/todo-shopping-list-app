import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/word.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var wordState = context.watch<WordState>();
    var favorites = wordState.getFavorites();

    return ListView(
      children: <Widget>[
        Text('All favorites'),
        Text(favorites.length.toString()),
        for (var fav in favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(fav.asLowerCase),
          )
      ],
    );
  }
}
