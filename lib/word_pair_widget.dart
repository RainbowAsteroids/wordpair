import 'package:flutter/material.dart';

class WordPairWidget extends StatelessWidget {
  final bool favorite;
  final String wordPair;
  final void Function() onTap;

  const WordPairWidget(
      {super.key,
      required this.favorite,
      required this.wordPair,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    const verticalPadding = 40.0;
    const horizontalPadding = 100.0;

    return ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.only(
          left: horizontalPadding,
          right: horizontalPadding,
          top: verticalPadding,
          bottom: verticalPadding,
        ),
        title: Text(
            style: const TextStyle(
              fontSize: 38,
            ),
            wordPair),
        trailing: Icon(
            // size: 48,
            color: favorite
                ? Colors.red
                : Theme.of(context).colorScheme.onBackground,
            favorite ? Icons.favorite : Icons.favorite_outline));
  }
}

