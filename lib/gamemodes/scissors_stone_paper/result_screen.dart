import 'package:championship/components/player.dart';
import 'package:championship/gamemodes/scissors_stone_paper/gesture.dart';
import 'package:championship/gamemodes/scissors_stone_paper/player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final SspPlayer player1;
  final SspPlayer player2;
  final Function(Player winner) continueCallbackFinish;

  ResultScreen(this.player1, this.player2, this.continueCallbackFinish);

  SspPlayer calculateWinner() {
    print("[ResultScreen - calculateWinner] Player1: ${player1?.name ?? "-"} ${player1?.id ?? "-"} ${player1?.gesture ?? "-"}");
    print("[ResultScreen - calculateWinner] Player2: ${player2?.name ?? "-"} ${player2?.id ?? "-"} ${player2?.gesture ?? "-"}");
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
    SspPlayer winner = calculateWinner();
    if (winner == null) {
      return Scaffold(
          body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.blue, Colors.white])),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/draw.png', width: 150),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Leider Unentschieden",
                style: TextStyle(fontSize: 25),
              ),
            ),
            Container(
                padding: EdgeInsets.all(50),
                child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.orange, width: 3)),
                    child: Padding(
                        padding: EdgeInsets.all(1),
                        child: CupertinoButton(
                            child: Text("Rematch", style: TextStyle(fontSize: 20, color: Colors.blue)),
                            onPressed: () => continueCallbackFinish(null)))))
          ],
        )),
      ));
    } else {
      return Scaffold(
          body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.blue, Colors.white])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 1,
            ),
            Row(
              children: [
                Spacer(
                  flex: 1,
                ),
                gestureToImage(player1.gesture),
                Text(
                  player1.name,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(
                  flex: 1,
                ),
                Text(
                  "vs.",
                  style: TextStyle(fontSize: 25),
                ),
                Spacer(
                  flex: 1,
                ),
                Text(
                  player2.name,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
                gestureToImage(player2.gesture),
                Spacer(
                  flex: 1,
                ),
              ],
            ),
            Spacer(
              flex: 1,
            ),
            Image.asset('assets/images/wreath.png', width: 150),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Sieg für ${winner.name}",
                style: TextStyle(fontSize: 25),
              ),
            ),
            Container(
              padding: EdgeInsets.all(50),
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.orange, width: 3)),
                child: Padding(
                  padding: EdgeInsets.all(1),
                  child: CupertinoButton(
                    child: Text(
                      "Weiter",
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                    onPressed: () {
                      continueCallbackFinish(Player(winner.name));
                    },
                  ),
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ));
    }
  }

  Image gestureToImage(int gesture) {
    switch (gesture) {
      case 0:
        return Image.asset('assets/images/scissors.png', width: 50);
        break;
      case 1:
        return Image.asset('assets/images/rock.png', width: 50);
        break;
      case 2:
        return Image.asset('assets/images/paper.png', width: 50);
        break;
    }
    return null;
  }
}
