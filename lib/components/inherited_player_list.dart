import 'package:champion_chip/components/player.dart';
import 'package:flutter/material.dart';

class InheritedPlayerList extends InheritedWidget {
  final InheritedPlayerListService service = InheritedPlayerListService();

  InheritedPlayerList(Widget child, {List<Player> players}) : super(child: child) {
    if (players != null) {
      this.service.players = players;
    }
  }

  @override
  bool updateShouldNotify(InheritedPlayerList oldWidget) {
    return service.players != oldWidget.service.players;
  }

  static InheritedPlayerList of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<InheritedPlayerList>();
}

class InheritedPlayerListService {
  List<Player> players;

  InheritedPlayerListService({List<Player> players}) {
    this.players = (players != null ? players : []);
  }
}
