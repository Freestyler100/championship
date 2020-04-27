import 'package:champion_chip/components/player.dart';
import 'package:champion_chip/states/game/gamemodes/scissors_stone_paper/gesture.dart';
import 'package:champion_chip/states/game/gamemodes/scissors_stone_paper/player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  SspPlayer player1;
  SspPlayer player2;
  Function continueCallback;

  ResultScreen(this.player1, this.player2, this.continueCallback);

  SspPlayer calculateWinner() {
    print("Result - calcWinner");
    print("Player1 - ${player1.name} - ${player1.id} - ${player1.gesture}");
    print("Player2 - ${player2.name} - ${player2.id} - ${player2.gesture}");
    print("Player1: " + player1.gesture.toString());
    print("Player2: " + player2.gesture.toString());

    if (player2 == null) return player1;

    switch (player1.gesture) {
      case Gesture.SCISSOR:
        if (player2.gesture == Gesture.SCISSOR) return null;
        if (player2.gesture == Gesture.STONE) return player2;
        if (player2.gesture == Gesture.PAPER) return player1;
        break;
      case Gesture.STONE:
        if (player2.gesture == Gesture.SCISSOR) return player1;
        if (player2.gesture == Gesture.STONE) return null;
        if (player2.gesture == Gesture.PAPER) return player2;
        break;
      case Gesture.PAPER:
        if (player2.gesture == Gesture.SCISSOR) return player2;
        if (player2.gesture == Gesture.STONE) return player1;
        if (player2.gesture == Gesture.PAPER) return null;
        break;
    }
    print("fehler");
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (calculateWinner() == null) {
      return Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Leider Unentschieden"), CupertinoButton(child: Text("Rematch"), onPressed: () => continueCallback())],
        )),
      );
    } else {
      return Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sieg für ${calculateWinner().name}"),
            CupertinoButton(
              child: Text("Weiter"),
              onPressed: continueCallback,
            )
          ],
        )),
      );
    }
  }
}
