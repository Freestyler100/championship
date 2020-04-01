import 'package:champion_chip/constants.dart';
import 'package:champion_chip/game/game_controller.dart';
import 'package:champion_chip/player.dart';
import 'package:champion_chip/select_players/select_players_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainController extends StatefulWidget {
  _MainControllerState viewState;
  int gameStateNum;
  PlayerList playerList;

  MainController() {
    viewState = _MainControllerState(this);
    gameStateNum = GAMESTATE.SELECT_PLAYERS_STATE;
    playerList = PlayerList([]);
  }

  void setGameState(int newGameState) => viewState.setGameState(newGameState);

  @override
  _MainControllerState createState() => viewState;
}

class _MainControllerState extends State<MainController> {
  MainController mainController;
  _MainControllerState(this.mainController);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlayerList>(
      create: (_) => widget.playerList,
      child: stateManager(),
    );
  }

  Widget stateManager() {
    switch (widget.gameStateNum) {
      case GAMESTATE.GAME_STATE:
        return GameController();
        break;
      case GAMESTATE.SCOREBOARD_STATE:
        return Center(child: Text("SCOREBOARD_STATE"));
        break;
      default:
        return SelectPlayersView(this.widget, widget.playerList);
        break;
    }
  }

  setGameState(int gameState) {
    if (gameState != widget.gameStateNum)
      setState(() {
        widget.gameStateNum = gameState;
      });
  }
}
