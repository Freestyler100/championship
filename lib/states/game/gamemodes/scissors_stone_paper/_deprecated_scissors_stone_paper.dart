import 'package:champion_chip/components/player.dart';
import 'package:champion_chip/constants.dart';
import 'package:champion_chip/states/game/gamemodes/scissors_stone_paper/player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScissorsStonePaperGamemode extends StatefulWidget {
  List<SspPlayer> players;

  ScissorsStonePaperGamemode(Player player1, Player player2) {
    players[0] = player1;
    players[1] = player2;
  }
  @override
  _ScissorsStonePaperGamemodeState createState() => _ScissorsStonePaperGamemodeState();
}

class _ScissorsStonePaperGamemodeState extends State<ScissorsStonePaperGamemode> {
  int nextPlayer;
  int matchstate;

  @override
  void initState() {
    nextPlayer = 0;
    matchstate = MATCHSTATE.WAITING;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(widget.players[nextPlayer].name + " ist dran"),
      ),
      body: Column(
        children: <Widget>[
          CupertinoButton(
              child: null,
              onPressed: () {
                widget.players[nextPlayer].gesture = 0;
              }),
        ],
      ),
    );
  }
}
