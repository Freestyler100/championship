import 'package:flutter/material.dart';

class InheritedGamemode extends InheritedWidget {
  final InheritedGamemodeService service = InheritedGamemodeService();

  InheritedGamemode(Widget child, {int gamemode}) : super(child: child) {
    if (gamemode != null) {
      this.service.gamemode = gamemode;
    }
  }

  @override
  bool updateShouldNotify(InheritedGamemode oldWidget) {
    return service.gamemode != oldWidget.service.gamemode;
  }

  static InheritedGamemode of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<InheritedGamemode>();
}

class InheritedGamemodeService {
  int gamemode;

  InheritedGamemodeService({int gamemode}) {
    this.gamemode = (gamemode != null ? gamemode : 0);
  }
}
