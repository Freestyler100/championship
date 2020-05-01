import 'package:championship/gamemodes/scissors_stone_paper/round_result.dart';
import 'package:championship/gamemodes/scissors_stone_paper/scoreboard_view.dart';
import 'package:flutter/material.dart';

class ScoreboardView extends StatelessWidget {
  final List<RoundResult> roundResults;
  final Function(int state) continueCallback;

  const ScoreboardView(this.roundResults, this.continueCallback, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SSPScoreboardView(roundResults, continueCallback);
  }
}
