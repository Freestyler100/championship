import 'package:flutter/material.dart';

class Player {
  String name;

  Player(this.name);
}

class PlayerList with ChangeNotifier {
  List<Player> _players;

  PlayerList(this._players);

  List<Player> get players => _players;

  setPlayers(List<Player> players) {
    _players = players;
    notifyListeners();
  }

  setPlayerAt(int index, Player player) {
    _players[index] = player;
    notifyListeners();
  }

  removePlayerAt(int index) {
    _players.removeAt(index);
    notifyListeners();
  }

  addPlayer(Player player) {
    _players.add(player);
    notifyListeners();
  }
}
