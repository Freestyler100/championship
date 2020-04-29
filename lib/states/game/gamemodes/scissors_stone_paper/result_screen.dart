import 'package:champion_chip/states/game/gamemodes/scissors_stone_paper/gesture.dart';
import 'package:champion_chip/states/game/gamemodes/scissors_stone_paper/player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  SspPlayer player1;
  SspPlayer player2;
  Function continueCallbackFinish;

  ResultScreen(this.player1, this.player2, this.continueCallbackFinish);

  SspPlayer calculateWinner() {
    print(0);
    // print("Result - calcWinner");
    // print("Player1 - ${player1.name} - ${player1.id} - ${player1.gesture}");
    // print("Player2 - ${player2?.name ?? '-'} - ${player2?.id ?? "-"} - ${player2?.gesture ?? "-"}");
    // print("Player1: " + player1.gesture.toString());
    // print("Player2: " + player2?.gesture?.toString() ?? "-");

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
        body: Container(
            decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.blue, Colors.white])),
            child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/draw.png', width: 150),
            Padding(padding: EdgeInsets.all(15),
                child: Text("Leider Unentschieden", style: TextStyle(fontSize: 25),), 
              ),
            Container(
                padding: EdgeInsets.all(50),
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.orange, width: 3)),
               child: Padding(padding: EdgeInsets.all(1),
                child:
                CupertinoButton(
                child: Text("Rematch",style: TextStyle(fontSize: 20, color: Colors.blue)), onPressed: () => continueCallbackFinish()
                )
              )))
          ],
        )),
        )
      );
    } else {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.blue, Colors.white])),
          child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/wreath.png', width: 150),
              Padding(padding: EdgeInsets.all(15),
              child: Text("Sieg für ${calculateWinner().name}", style: TextStyle(fontSize: 25),),
              ),
              Container(
                padding: EdgeInsets.all(50),
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.orange, width: 3)),
               child: Padding(padding: EdgeInsets.all(1),
                child: CupertinoButton(
                  child: Text("Weiter",style: TextStyle(fontSize: 20, color: Colors.blue),),
                  onPressed: () {
                    continueCallbackFinish();
                  },
                )
               
               )
              )
              )
            ],
          ),
        ),
        )
      );
    }
  }
}
