import 'package:championship/components/player.dart';

class SspPlayer extends Player {
  static int _nextId = 0;
  int id;
  int points;
  int gesture;

  SspPlayer(String name) : super(name) {
    id = _nextId;
    _nextId++;
  }
}
