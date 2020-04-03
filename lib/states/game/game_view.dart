import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text("Spieler 1 vs. Spieler 2"),
      ),
      body: Center(
        child: Text("[GAME_VIEW]"),
      ),
    );
  }
}
