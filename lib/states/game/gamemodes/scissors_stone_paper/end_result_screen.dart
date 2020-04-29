import 'package:champion_chip/components/player.dart';
import 'package:flutter/material.dart';

class EndResultScreen extends StatelessWidget {
  final Player winner;

  EndResultScreen(this.winner);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('[Siegerehrungsscreen]'),
            Text('Spieler ${winner.name} hat das Turnier gewonnen!'),
          ],
        ),
      ),
    );
  }
}
