import 'package:championship/components/player.dart';

class SspPlayer extends Player {
  int points;
  int gesture;

  SspPlayer(String name) : super(name);

  SspPlayer.fromPlayer(Player player) : super(player.name, id: player.id);
}
