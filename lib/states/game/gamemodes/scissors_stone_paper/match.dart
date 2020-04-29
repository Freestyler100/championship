import 'package:champion_chip/components/player.dart';
import 'package:champion_chip/states/game/gamemodes/scissors_stone_paper/battle_screen.dart';
import 'package:champion_chip/states/game/gamemodes/scissors_stone_paper/gesture.dart';
import 'package:champion_chip/states/game/gamemodes/scissors_stone_paper/handover_screen.dart';
import 'package:champion_chip/states/game/gamemodes/scissors_stone_paper/player.dart';
import 'package:champion_chip/states/game/gamemodes/scissors_stone_paper/result_screen.dart';
import 'package:flutter/material.dart';

class Match {
  SspPlayer player1;
  SspPlayer player2;
  PageView _currentScreen;
  int _currentScreenIndex;
  Function(Player) matchFinishedCallback;

  Match(Player _player1, Player _player2, this.matchFinishedCallback) {
    player1 = SspPlayer(_player1.name);
    player2 = (_player2 != null ? SspPlayer(_player2.name) : null);
    _currentScreen = PageView(children: <Widget>[Scaffold(body: Center(child: Text("Dieser Bildschirm sollte nicht angezeigt werden")))]);
    _currentScreenIndex = 0;

    if (player2 == null) {
      //matchFinishedCallback(this.player1);
    } else
      _currentScreen = PageView(
        children: <Widget>[
          HandoverScreen(player1, nextScreen),
          BattleScreen(player1, nextScreen),
          HandoverScreen(player2, nextScreen),
          BattleScreen(player2, nextScreen),
          ResultScreen(player1, player2, continueCallback),
        ],
      );
  }

  continueCallback(Player winner) {
    print("[Match] continueCallbackBackToMatch");
    if (winner == null) {
      //rematch
      _currentScreenIndex = 0;
      _currentScreen.controller.jumpToPage(0);
    } else {
      matchFinishedCallback(winner);
    }
  }

  nextScreen() {
    _currentScreenIndex++;

    _currentScreen.controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.bounceIn);
  }

  SspPlayer calculateWinner() {
    print("[Match - calculateWinner] Player1 - ${player1?.name ?? "-"} - ${player1?.id ?? "-"} - ${player1?.gesture ?? "-"}");
    print("[Match - calculateWinner] Player2 - ${player2?.name ?? "-"} - ${player2?.id ?? "-"} - ${player2?.gesture ?? "-"}");
    // print("Player1: " + player1.gesture.toString());
    // print("Player2: " + player2.gesture.toString());

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

  get currentScreen => _currentScreen;
}
