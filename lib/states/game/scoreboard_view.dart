import 'package:champion_chip/components/player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScoreboardView extends StatelessWidget {
  final Player winner;

  const ScoreboardView(this.winner, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("[SCOREBOARD_VIEW]"),
            Text("${winner.name} hat das Turnier gewonnen"),
          ],
        ),
      ),
    );
  }
}
