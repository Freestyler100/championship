import 'package:championship/components/player.dart';
import 'package:championship/states/game/gamemodes/scissors_stone_paper/player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HandoverScreen extends StatelessWidget {
  SspPlayer player;
  Function continueCallback;

  HandoverScreen(this.player, this.continueCallback);

  @override
  Widget build(BuildContext context) {
    print("[HandoverScreen - build]");
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.blue, Colors.white])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(children: [
                Text('${player.name} ist jetzt dran.', style: TextStyle(fontSize: 30)),
                Text('Bitte reichen Sie das Gerät weiter.', style: TextStyle(fontSize: 22)),
              ]),
              Container(
                child: CupertinoButton(
                  onPressed: continueCallback,
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.orange, width: 3)),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Los geht\'s!',
                        style: TextStyle(fontSize: 30, color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
