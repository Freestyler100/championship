import 'package:champion_chip/components/player.dart';
import 'package:champion_chip/states/game/gamemodes/scissors_stone_paper/gesture.dart';

class SspPlayer extends Player {
  int points;
  int gesture;

  SspPlayer(String name) : super(name);

  int schnicken() {
    if (!isComputer && gesture != null)
      return gesture;
    else
      return Gesture.randomGesture();
  }
}
