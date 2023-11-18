import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:wordpair/saved_word_list.dart';

import 'package:wordpair/word_pair_widget.dart';
import 'package:wordpair/consts.dart';

class WordPairExplorer extends StatefulWidget {
  final List<String> savedWordPairs;
  final void Function(String) toggleWordPair;
  const WordPairExplorer(
      {super.key, required this.savedWordPairs, required this.toggleWordPair});

  @override
  State<WordPairExplorer> createState() => _WordPairExplorerState();
}

class _WordPairExplorerState extends State<WordPairExplorer> {
  List<String> _wordPairs = generateWordPairs().take(500).map((wp) => wp.asPascalCase).toList();

  Widget _buildList() {
    return ListView.builder(itemBuilder: (buildContext, index) {
      if (index.isOdd) {
        const margin = 45.0;
        return Container(
            margin: EdgeInsets.only(left: margin, right: margin),
            child: Divider());
      }

      final listIndex = index ~/ 2;

      while (listIndex >= _wordPairs.length) {
        _wordPairs.addAll(generateWordPairs().take(_wordPairs.length).map((wp) => wp.asPascalCase));
      }

      final wordPair = _wordPairs[listIndex];
      // final favorite = true;
      final favorite = widget.savedWordPairs.contains(wordPair);
      return WordPairWidget(
        favorite: favorite,
        wordPair: wordPair,
        onTap: () => widget.toggleWordPair(wordPair),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            margin: EdgeInsets.only(left: appBarMargin),
            child: Text("Word Pair Explorer")),
        actions: [
          Container(
            margin: EdgeInsets.only(right: appBarMargin),
            child: IconButton(
              iconSize: 72,
              onPressed: () { Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => SavedWordList(
                    savedWordPairs: widget.savedWordPairs, 
                    toggleWordPair: widget.toggleWordPair
                  ))
                );
              },
              icon: Icon(Icons.list),
            ),
          )
        ],
      ),
      body: _buildList(),
    );
  }
}

