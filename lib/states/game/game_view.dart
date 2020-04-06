import 'package:champion_chip/components/inherited_player_list.dart';
import 'package:champion_chip/states/game/gamemodes/scissors_stone_paper/scissors_stone_paper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  int gamemode = 0; //TODO: change this to implement more gamemodes

  @override
  Widget build(BuildContext context) {
    switch (gamemode) {
      case 0:
        print("build ssp");
        print(InheritedPlayerList.of(context).service.players);
        return ScissorsStonePaperGamemode(
          InheritedPlayerList.of(context).service.players[0],
          InheritedPlayerList.of(context).service.players[1],
        );
        break;
      default:
    }
  }
}
