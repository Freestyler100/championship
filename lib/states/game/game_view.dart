import 'dart:math';

import 'package:champion_chip/components/inherited_player_list.dart';
import 'package:champion_chip/components/player.dart';
import 'package:champion_chip/states/game/gamemodes/scissors_stone_paper/match.dart';
import 'package:champion_chip/states/game/gamemodes/scissors_stone_paper/result_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameLogic extends StatefulWidget {
  @override
  _GameLogicState createState() => _GameLogicState();
}

class _GameLogicState extends State<GameLogic> {
  int gamemode = 0; //TODO: change this to implement more gamemodes
  List<Player> players;
  Widget battleScreen;
  List<Match> matches;
  int currentMatch;
  List<Player> winners = List<Player>();

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
      matches.add(Match(players[i], (i + 1 < players.length ? players[i + 1] : null), matchFinished));
    }
    return matches;
  }

  matchFinished(Player player) {
    print('match finished');
    setState(() {
      print(player.name + ' hat gewonnen');
      if (currentMatch < matches.length) {
        winners.add(player);
        currentMatch++;
      } else {
        if (winners.length > 1) {
          players = winners.toList();
          createMatches();
          print("nächste runde");
        } else {
          print('${winners[0].name} hat das Turnier gewonnen!');
          battleScreen = ResultScreen(player, null, newGame);
        }
      }
    });
  }

  newGame() {
    print('Neues Spiel starten...');
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
