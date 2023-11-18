import 'package:flutter/material.dart';
import 'package:wordpair/word_pair_widget.dart';

class SavedWordList extends StatelessWidget {
  final List<String> savedWordPairs;
  final void Function(String) toggleWordPair;
  const SavedWordList({super.key, required this.savedWordPairs, required this.toggleWordPair});

  Widget _buildList() {
    return ListView.builder(itemBuilder: (context, index) {
      if (index.isOdd) {
        const margin = 45.0;
        return Container(
            margin: EdgeInsets.only(left: margin, right: margin),
            child: Divider());
      }

      final listIndex = index ~/ 2;
      if (listIndex < savedWordPairs.length - 1) {
      final wp = savedWordPairs[listIndex];
        return WordPairWidget(
          favorite: true, 
          wordPair: wp, 
          onTap: () => toggleWordPair(wp) 
        );
      }

      return null;
    });
    /* return ListView(
      children: savedWordPairs.map((wp) => WordPairWidget(
        favorite: savedWordPairs.contains(wp),
        wordPair: wp,
        onTap: () => toggleWordPair(wp),
    )).toList()); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          // margin: EdgeInsets.only(left: appBarMargin),
          child: Text("Saved Word Pairs")
        ),
        leadingWidth: 128,
      ),
      body: _buildList(),
    );
  }
}

