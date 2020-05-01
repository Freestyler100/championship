import 'package:championship/components/inherited_player_list.dart';
import 'package:championship/constants.dart';
import 'package:championship/game_logic.dart';
import 'package:championship/gamemodes/scissors_stone_paper/round_result.dart';
import 'package:championship/scoreboard_view.dart';
import 'package:championship/select_players_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(ChampionshipGame());

class ChampionshipGame extends StatefulWidget {
  @override
  _ChampionshipGameState createState() => _ChampionshipGameState();
  final inheritedPlayerListService = InheritedPlayerListService(players: []);
}

class _ChampionshipGameState extends State<ChampionshipGame> {
  int appState;
  List<RoundResult> roundResults;

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
        currentScreen = GameLogic((List<RoundResult> _results) {
          setState(() {
            roundResults = _results;
            appState = APPSTATE.SCOREBOARD_STATE;
          });
        });
        break;
      case APPSTATE.SCOREBOARD_STATE:
        print('[Main - build] case: SCOREBOARD_STATE');
        currentScreen = ScoreboardView(roundResults, (int _appState) {
          setState(() {
            appState = _appState;
          });
        });
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
