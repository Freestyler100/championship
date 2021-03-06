import 'dart:math';

import 'package:championship/components/inherited_player_list.dart';
import 'package:championship/components/player.dart';
import 'package:championship/gamemodes/scissors_stone_paper/match.dart';
import 'package:championship/gamemodes/scissors_stone_paper/player.dart';
import 'package:championship/gamemodes/scissors_stone_paper/round_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameLogic extends StatefulWidget {
  final Function(List<RoundResult> roundResults) showScoreboardCallback;

  GameLogic(this.showScoreboardCallback, {Key key}) : super(key: key) {
    print("[GameLogic] create new instance");
  }

  @override
  _GameLogicState createState() => _GameLogicState();
}

class _GameLogicState extends State<GameLogic> {
  int gamemode = 0; //TODO: change this to implement more gamemodes
  List<Player> players;
  List<Match> matches;
  int currentMatch;
  List<Player> winners = List<Player>();
  Widget resultScreen;
  List<RoundResult> roundResults = List<RoundResult>();
  int layer;

  @override
  void didChangeDependencies() {
    players = InheritedPlayerList.of(context).service.players.toList();
    players = mixPlayerList(players);

    matches = createMatches();
    currentMatch = 0;

    layer = 0;

    super.didChangeDependencies();
  }

  List<Match> createMatches() {
    List<Match> matches = List<Match>();
    for (int i = 0; i < players.length; i += 2) {
      matches.add(Match(players[i], (i + 1 < players.length ? players[i + 1] : null), matchFinished));
    }
    return matches;
  }

  matchFinished(Player player) {
    roundResults.add(RoundResult(
      matches[currentMatch].player1,
      matches[currentMatch].player2,
      (matches[currentMatch].player1.name == player.name ? matches[currentMatch].player1 : matches[currentMatch].player2),
      layer,
    ));
    print('[GameLogic - matchFinished] match finished with player: ${player.name}');
    setState(() {
      if (currentMatch + 1 < matches.length) {
        // print('[GameLogic - matchFinished] more than one further matches aviable for this round');
        // print('[GameLogic - matchFinished] prepare for next MATCH');
        winners.add(player);
        currentMatch++;
        if (matches[currentMatch].player2 == null) {
          // print("[GameLogic - matchFinished] next Match only one Player, skip, currentMatch($currentMatch) ++ ");
          winners.add(matches[currentMatch].player1);
          roundResults.add(RoundResult(matches[currentMatch].player1, null, matches[currentMatch].player1, layer));
          players = winners.toList();
          players = mixPlayerList(players);
          winners = List<Player>();
          matches = createMatches();
          layer++;
          currentMatch = 0;
        }
      } else {
        winners.add(player);
        if (winners.length > 1) {
          // print('[GameLogic - matchFinished] one further MATCH is aviable for this ROUND');
          // print('[GameLogic - matchFinished] prepare for next ROUND');
          players = winners.toList();
          players = mixPlayerList(players);
          winners = List<Player>();
          matches = createMatches();
          layer++;
          currentMatch = 0;
          if (matches[currentMatch].player2 == null) {
            // print("[GameLogic - matchFinished] next MATCH only one Player, skip, currentMatch($currentMatch) ++ ");
            roundResults.add(RoundResult(matches[currentMatch].player1, null, player, layer));
            currentMatch++;
          }
        } else {
          // print('[GameLogic - matchFinished] no further matches aviable for this ROUND');
          // print('[GameLogic - matchFinished] not enough players for further ROUND');
          // print('[GameLogic - matchFinished] ${player.name} has won the championship!');
          widget.showScoreboardCallback(roundResults);
        }
      }
    });
  }

  void newGame() {
    print('Neues Spiel starten...');
  }

  @override
  Widget build(BuildContext context) {
    print("[GameLogic - build] match $currentMatch from matches.length: ${matches.length}");
    print(
        "[GameLogic - build] Player1: ${matches[currentMatch].player1?.name ?? "-"} ${matches[currentMatch].player1?.id ?? "-"} ${matches[currentMatch].player1?.gesture ?? "NoGesture"}");
    print(
        "[GameLogic - build] Player2: ${matches[currentMatch].player2?.name ?? "-"} ${matches[currentMatch].player2?.id ?? "-"} ${matches[currentMatch].player2?.gesture ?? "NoGesture"}");

    return matches[currentMatch].currentScreen;
    // switch (gamemode) {
    //   case 0:
    //     print("ssp " + InheritedPlayerList.of(context).service.players.map((a) => ("'${a.name}'")).toList().toString());

    //     return ScissorsStonePaperGamemode(
    //       InheritedPlayerList.of(context).service.players[0],
    //       InheritedPlayerList.of(context).service.players[1],
    //     );
    //     break;
    //   default:
    // }
  }

  List<Player> mixPlayerList(List<Player> players) {
    List<Player> tmpPlayers = List<Player>(players.length);
    var rndNum;
    for (int i = 0; i < players.length; i++) {
      do {
        rndNum = Random().nextInt(players.length);
      } while (tmpPlayers[rndNum] != null);
      tmpPlayers[rndNum] = players[i];
    }
    return tmpPlayers;
  }
}

///1. SpielerList in i = 2er steps durchgehen ubd jeweils i und i + 1 gegeneinander spielen lassen
///2.  => gewinner in winnerList schreiben (bis spielerList durchlaufen)
///3. Schritt 1 mit neuer winnerList wiederholen
///   Solange bis WinnerList.len == 1

///os > info > evaluator project
