import 'package:champion_chip/states/game/gamemodes/scissors_stone_paper/gesture.dart';
import 'package:champion_chip/states/game/gamemodes/scissors_stone_paper/player.dart';
import 'package:flutter/material.dart';

class BattleScreen extends StatelessWidget {
  final SspPlayer player;
  final Function nextCallback;
  final Function(SspPlayer, int) setGestureCallback;

  BattleScreen(this.player, this.nextCallback, this.setGestureCallback);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.blue, Colors.white])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(children: [
                Text('${player.name}', style: TextStyle(fontSize: 30, color: Colors.white)),
                Text('Wähle weise...', style: TextStyle(fontSize: 30))
              ]),
              Container(
                child: OutlineButton(
                  onPressed: () {
                    print(0);
                    player.gesture = Gesture.SCISSOR;
                    print(1);
                    setGestureCallback(player, Gesture.SCISSOR);
                    print(2);
                    nextCallback();
                    print(3);
                  },
                  borderSide: BorderSide(width: 3, color: Colors.black),
                  highlightedBorderColor: Colors.black,
                  child: Image.asset('assets/images/scissors.png', width: 100),
                ),
              ),
              Container(
                child: OutlineButton(
                  onPressed: () {
                    player.gesture = Gesture.STONE;
                    setGestureCallback(player, Gesture.STONE);
                    nextCallback();
                  },
                  borderSide: BorderSide(width: 3, color: Colors.black),
                  highlightedBorderColor: Colors.black,
                  child: Image.asset('assets/images/rock.png', width: 100),
                ),
              ),
              Container(
                child: OutlineButton(
                  onPressed: () {
                    player.gesture = Gesture.PAPER;
                    setGestureCallback(player, Gesture.PAPER);
                    nextCallback();
                  },
                  borderSide: BorderSide(width: 3, color: Colors.black),
                  highlightedBorderColor: Colors.black,
                  child: Image.asset('assets/images/paper.png', width: 100),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
