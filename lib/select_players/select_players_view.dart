import 'package:champion_chip/constants.dart';
import 'package:champion_chip/player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:champion_chip/maincontroller.dart';

class SelectPlayersView extends StatefulWidget {
  MainController _mainController;
  _SelectPlayersViewState _selectPlayersViewState;
  PlayerList _playersTmp;
  bool canContinue = false;

  SelectPlayersView(this._mainController, PlayerList playerList) {
    print("pre:" + playerList.players.toString());
    _playersTmp = PlayerList(playerList.players.toList());
    while (_playersTmp.players.length < 2) {
      _playersTmp.players.add(Player(""));
    }
    print("post:" + playerList.players.toString());
  }

  @override
  _SelectPlayersViewState createState() {
    if (_selectPlayersViewState == null) _selectPlayersViewState = _SelectPlayersViewState();
    return _selectPlayersViewState;
  }

  // TextField newPlayerTextField([String text]) {
  //   return TextField(
  //     onChanged: (_) => _selectPlayersViewState.nameFieldChangedEvent(),
  //     decoration: InputDecoration(hintText: "Name eintragen"),
  //     controller: TextEditingController.fromValue(TextEditingValue(text: (text != null ? text : ""))),
  //   );
  // }
}

class _SelectPlayersViewState extends State<SelectPlayersView> {
  @override
  Widget build(BuildContext context) {
    print(widget._playersTmp.players);
    print("build");
    return Scaffold(
      appBar: CupertinoNavigationBar(
          leading: Icon(CupertinoIcons.person),
          middle: Text("Spieler hinzufügen"),
          trailing: CupertinoButton(
            padding: EdgeInsets.all(0),
            child: Icon(
              CupertinoIcons.check_mark,
              size: 40,
            ),
            onPressed: (!widget.canContinue
                ? null
                : () {
                    Provider.of<PlayerList>(context, listen: false).setPlayers(widget._playersTmp.players);
                    widget._mainController.setGameState(GAMESTATE.GAME_STATE);
                  }),
          )),
      body: Column(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: (widget._playersTmp.players.length >= 2 ? widget._playersTmp.players.length : 2),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.only(left: 16),
                height: 50,
                child: Center(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp("[a-zA-Z]")),
                      ],
                      onChanged: (text) => textFieldChangedEvent(text, index, widget._playersTmp),
                      decoration: InputDecoration(
                        hintText: "Spieler " + (index + 1).toString(),
                      ),
                      controller: TextEditingController.fromValue(
                        TextEditingValue(
                            text: widget._playersTmp.players[index].name,
                            selection: TextSelection.collapsed(offset: widget._playersTmp.players[index].name.length)),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void textFieldChangedEvent(String text, int index, PlayerList playerList) {
    print("TextField changed at ListView[" + index.toString() + "], text: " + text);

    for (int i = 0; i < widget._playersTmp.players.length; i++) {
      print("playerList[$i] = " + widget._playersTmp.players[i].name);
    }

    widget._playersTmp.setPlayerAt(index, Player(text));

    bool emptyFieldExists = false;

    widget._playersTmp.players.forEach((p) {
      print("p.name:" + p.name + " emptyFieldExists: " + (p.name == "" ? true : false).toString());
      if (p.name == "") emptyFieldExists = true;
    });

    print("emptyFieldExists:" + emptyFieldExists.toString());
    if (!emptyFieldExists) {
      setState(() {
        widget._playersTmp.addPlayer(Player(""));
        print("new field added");
      });
    }
    print("changed_end");

    checkPlayerCount();
  }

  void showPlayerLists(BuildContext context) {
    print("showPlayerLists");
    print("old: " + Provider.of<PlayerList>(context, listen: false).players.toString());
    print("tmp_new: " + widget._playersTmp.players.toString());
  }

  void checkPlayerCount() {
    int filledFields = 0;

    widget._playersTmp.players.forEach((p) {
      if (p.name != "") filledFields += 1;
    });

    var tmp = widget.canContinue;

    widget.canContinue = filledFields >= 2;

    if (widget.canContinue != tmp) setState(() {});
  }
}
