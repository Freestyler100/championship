import 'package:championship/gamemodes/scissors_stone_paper/player.dart';

class RoundResult {
  SspPlayer player1;
  SspPlayer player2;
  SspPlayer winner;
  int layer;

  get loser => (winner.name == player1.name ? player2 : player1);

  RoundResult(this.player1, this.player2, this.winner, this.layer);
}
