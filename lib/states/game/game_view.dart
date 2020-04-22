import 'dart:math';

import 'package:champion_chip/components/inherited_player_list.dart';
import 'package:champion_chip/components/player.dart';
import 'package:champion_chip/states/game/gamemodes/scissors_stone_paper/match.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  int gamemode = 0; //TODO: change this to implement more gamemodes
  List<Player> players;
  Widget battleScreen;
  List<Match> matches;
  int currentMatch;

  @override
  void didChangeDependencies() {
    players = InheritedPlayerList.of(context).service.players.toList();
    players = mixPlayerList(players);

    matches = createMatches();
    currentMatch = 0;

    super.didChangeDependencies();
  }

  List<Match> createMatches() {
    List<Match> matches = List<Match>();
    for (int i = 0; i < players.length; i += 2) {
      matches.add(Match(players[i], (i + 1 <= players.length ? players[i + 1] : null), matchFinished));
    }
    return matches;
  }

  getWinner(Player player1, Player player2) {
    if (player1 == null) return player2;
    if (player2 == null) return player1;

    return getWinner(player1, player2);
  }

  matchFinished(Player player) {
    print(player.name + ' hat gewonnen');
  }

  @override
  Widget build(BuildContext context) {
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
