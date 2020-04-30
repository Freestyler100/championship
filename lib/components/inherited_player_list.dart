import 'package:championship/components/player.dart';
import 'package:flutter/material.dart';

class InheritedPlayerList extends InheritedWidget {
  //static final InheritedPlayerListService _service = InheritedPlayerListService();
  InheritedPlayerListService service;

  //factory InheritedPlayerListService._internal(Widget child, {List<Player> players}) => InheritedPlayerListService(child, players);
  InheritedPlayerList(Widget child, this.service) : super(child: child);

  // InheritedPlayerListService._internal(Widget child, {List<Player> players}) {}

  // InheritedPlayerList(Widget child, {List<Player> players}) : super(child: child) {
  //   if (players != null) this._service.players = players;
  // }

  @override
  bool updateShouldNotify(InheritedPlayerList oldWidget) {
    return service.players != oldWidget.service.players;
  }

  static InheritedPlayerList of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<InheritedPlayerList>();
}

class InheritedPlayerListService {
  List<Player> players;

  static final InheritedPlayerListService _instance = InheritedPlayerListService._internal();
  //factory InheritedPlayerListService() => _instance;

  InheritedPlayerListService._internal();

  factory InheritedPlayerListService({List<Player> players}) {
    _instance.players = (players != null ? players : []);

    print("[InheritedPlayerListService] new instance " + _instance.players.toString());
    return _instance;
  }
}
