import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

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
