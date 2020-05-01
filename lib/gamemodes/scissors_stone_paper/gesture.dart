import 'dart:math';

class Gesture {
  static const int SCISSOR = 0;
  static const int STONE = 1;
  static const int PAPER = 2;

  static int randomGesture() {
    return Random().nextInt(3);
  }
}
