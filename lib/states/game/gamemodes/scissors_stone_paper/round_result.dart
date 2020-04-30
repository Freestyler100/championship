import 'package:championship/components/player.dart';

class RoundResult {
  Player player1;
  Player player2;
  Player winner;
  int layer;

  get loser => (winner.name == player1.name ? player2 : player1);

  RoundResult(this.player1, this.player2, this.winner, this.layer);
}
