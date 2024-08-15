import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../states/app_state.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var favorites = appState.favorites;

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
