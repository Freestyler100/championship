import 'package:champion_chip/components/inherited_player_list.dart';
import 'package:champion_chip/components/player.dart';
import 'package:champion_chip/constants.dart';
import 'package:champion_chip/states/game/game_logic.dart';
import 'package:champion_chip/states/game/scoreboard_view.dart';
import 'package:champion_chip/states/game/select_players_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(ChampionChipGame());

class ChampionChipGame extends StatefulWidget {
  @override
  _ChampionChipGameState createState() => _ChampionChipGameState();
  final inheritedPlayerListService = InheritedPlayerListService(players: []);
}

class _ChampionChipGameState extends State<ChampionChipGame> {
  int appState;
  Player winner;

  @override
  void initState() {
    appState = APPSTATE.SELECT_PLAYERS_STATE;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen;

    switch (appState) {
      case APPSTATE.SELECT_PLAYERS_STATE:
        print('[Main - build] case: SELECT_PLAYERS_STATE');
        currentScreen = SelectPlayersView(() {
          setState(() {
            appState = APPSTATE.GAME_STATE;
          });
        });
        break;
      case APPSTATE.GAME_STATE:
        print('[Main - build] case: GAME_STATE');
        currentScreen = GameLogic((Player _winner) {
          setState(() {
            winner = _winner;
            appState = APPSTATE.SCOREBOARD_STATE;
          });
        });
        break;
      case APPSTATE.SCOREBOARD_STATE:
        print('[Main - build] case: SCOREBOARD_STATE');
        currentScreen = ScoreboardView(winner);
        break;
      default:
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InheritedPlayerList(
        currentScreen,
        widget.inheritedPlayerListService,
      ), //TODO: add later: InheritedGamemode(),
    );
  }
}

class A {
  String s;
}

class B extends A {
  void doSmth() {
    print(s);
  }
}

class CMain {
  void doSmth() {
    A a = A();
    B b = a;

    // B b = B();
    // A a = b;
  }
}
