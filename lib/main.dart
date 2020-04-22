import 'package:champion_chip/components/inherited_player_list.dart';
import 'package:champion_chip/constants.dart';
import 'package:champion_chip/states/game/game_view.dart';
import 'package:champion_chip/states/scoreboard/scoreboard_view.dart';
import 'package:champion_chip/states/select_players/select_players_view.dart';
import 'package:flutter/material.dart';

import 'components/inherited_gamemode.dart';

void main() => runApp(ChampionChipGame());

class ChampionChipGame extends StatefulWidget {
  @override
  _ChampionChipGameState createState() => _ChampionChipGameState();
  final inheritedPlayerListService = InheritedPlayerListService(players: []);
}

class _ChampionChipGameState extends State<ChampionChipGame> {
  int appState;

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
        currentScreen = SelectPlayersView(() {
          setState(() {
            appState = APPSTATE.GAME_STATE;
            print('show game state');
          });
        });
        break;
      case APPSTATE.GAME_STATE:
        currentScreen = GameView();
        break;
      case APPSTATE.SCOREBOARD_STATE:
        currentScreen = ScoreboardView();
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
