import 'package:champion_chip/components/player.dart';
import 'package:flutter/material.dart';

class EndResultScreen extends StatelessWidget {
  final Player winner;

  EndResultScreen(this.winner);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.blue, Colors.white])),
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(30),
              child: Image.asset('assets/images/trophy.png',width: 100),
            ),
            Text('Spieler ${winner.name}', style: TextStyle(fontSize: 30)),
            Text('hat das Turnier gewonnen!', style: TextStyle(fontSize: 30))
          ],
        ),
      ),
      )
    );
  }
}
