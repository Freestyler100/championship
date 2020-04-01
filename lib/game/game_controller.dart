import 'package:champion_chip/game/game_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameController extends StatefulWidget {
  _GameControllerState _gameControllerState;
  @override
  _GameControllerState createState() {
    _gameControllerState = _GameControllerState();
    return _gameControllerState;
  }

  startGame() {
    _gameControllerState.setState(() {
      //Game startk logic here
    });
  }
}

class _GameControllerState extends State<GameController> {
  @override
  Widget build(BuildContext context) {
    //
    // LOGIC

    return GameView();
  }
}
