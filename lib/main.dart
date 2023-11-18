import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wordpair/word_pair_explorer.dart';
import 'package:wordpair/consts.dart';

void main() {
  runApp(const WordPairApp());
}

class WordPairApp extends StatefulWidget {
  const WordPairApp({super.key});

  @override
  State<WordPairApp> createState() => _WordPairAppState();
}

class _WordPairAppState extends State<WordPairApp> {
  List<String> _savedWordPairs = [];

  Future<void> _loadSavedWordPairs() async {
    final swp = (await SharedPreferences.getInstance()).getStringList(savedWordPairsKey) ?? [];
    setState(() {
      _savedWordPairs = swp;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSavedWordPairs();
  }

  Future<void> _toggleWordPair(String s) async {
    final sf = await SharedPreferences.getInstance();
    setState(() {
      if (_savedWordPairs.contains(s)) {
        _savedWordPairs.remove(s);
      } else {
        _savedWordPairs.add(s);
      }

      sf.setStringList(savedWordPairsKey, _savedWordPairs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: GoogleFonts.quicksand().fontFamily,
          appBarTheme: AppBarTheme(
            // backgroundColor: Colors.orange[900],
            toolbarHeight: 150,
            titleTextStyle: TextStyle(
              fontSize: 56,
              fontFamily: GoogleFonts.redHatDisplay().fontFamily,
              fontWeight: FontWeight.w500,
            ),
          ),
          colorScheme: ColorScheme.dark(),
          iconTheme: IconThemeData(size: 48),
      ),
      home: WordPairExplorer(
        savedWordPairs: _savedWordPairs, 
        toggleWordPair: _toggleWordPair
      )
    );
  }
}
