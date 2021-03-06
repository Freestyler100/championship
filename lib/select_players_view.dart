import 'package:championship/components/inherited_player_list.dart';
import 'package:championship/components/player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectPlayersView extends StatefulWidget {
  final Function starteGameFunc;

  SelectPlayersView(this.starteGameFunc);

  @override
  _SelectPlayersViewState createState() => _SelectPlayersViewState();
}

class _SelectPlayersViewState extends State<SelectPlayersView> {
  bool readyToStart = false;
  List<Player> players;
  bool showMessageNoDoublePlayerNames = false;

  @override
  void initState() {
    readyToStart = false;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    players = InheritedPlayerList.of(context).service.players.toList();

    print('[SelectPlayersView - didChangeDependencies] current players ' + players.map((p) => (p?.name ?? "null")).toList().toString());

    while (players.length < 2) {
      players.add(Player(""));
    }

    print('[SelectPlayersView - didChangeDependencies] adapted players ' + players.map((p) => ((p?.name ?? "null"))).toList().toString());
    textFieldChangedEvent(players[0].name, 0);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
          backgroundColor: Colors.lightBlueAccent,
          leading: Icon(CupertinoIcons.person),
          middle: Text("Spieler hinzufügen"),
          trailing: CupertinoButton(
            padding: EdgeInsets.all(0),
            child: Icon(
              CupertinoIcons.check_mark,
              size: 40,
              color: (readyToStart ? Colors.white : Colors.grey),
            ),
            onPressed: (readyToStart
                ? () {
                    startGame(context);
                  }
                : null),
          )),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.blue, Colors.white])),
        child: Column(
          children: [
            if (showMessageNoDoublePlayerNames)
              Container(
                decoration: BoxDecoration(color: Colors.red),
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    'Du kannst keinen Namen doppelt vergeben',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: players.length,
              itemBuilder: (BuildContext context, int index) {
                // final _textField = TextField(
                //   focusNode: FocusNode(),
                //   autofocus: (index == 0),
                //   inputFormatters: [
                //     WhitelistingTextInputFormatter(RegExp("[a-zA-Z]")),
                //   ],
                //   onChanged: (text) => textFieldChangedEvent(text, index),
                //   decoration: InputDecoration(
                //     hintText: "Spieler " + (index + 1).toString(),
                //   ),
                //   controller: TextEditingController.fromValue(
                //     TextEditingValue(
                //       text: players[index].name,
                //       selection: TextSelection.collapsed(
                //         offset: players[index].name.length,
                //       ),
                //     ),
                //   ),
                // );

                // _textField.focusNode.addListener(() {
                //   if (!_textField.focusNode.hasFocus && _textField.controller.value.text == '') {
                //     _textField.focusNode.unfocus();
                //   }
                // });
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 50,
                  child: Center(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        autofocus: (index == 0),
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp("[a-zA-Z]")),
                        ],
                        onChanged: (text) => textFieldChangedEvent(text, index),
                        decoration: InputDecoration(
                          hintText: "Spieler " + (index + 1).toString(),
                        ),
                        controller: TextEditingController.fromValue(
                          TextEditingValue(
                            text: players[index].name,
                            selection: TextSelection.collapsed(
                              offset: players[index].name.length,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void startGame(BuildContext context) {
    //remove empty textfields and set global InheritedPlayerList to new players
    List<Player> tmpPlayers = [];
    players.forEach((p) {
      if (p.name != "") tmpPlayers.add(p);
    });
    InheritedPlayerList.of(context).service.players = tmpPlayers.toList();

    print("[SelectPlayersView - startGame] start GameLogic with players: " +
        InheritedPlayerList.of(context).service.players.map((p) => p.name).toList().toString());

    //start game
    widget.starteGameFunc();
  }

  void textFieldChangedEvent(String text, int index) {
    //update local players list
    players[index] = Player(text);

    //add new player if all name-textfields are filled
    bool emptyFieldExists = false;
    players.forEach((p) {
      if (p.name == "") emptyFieldExists = true;
    });

    if (!emptyFieldExists) {
      setState(() {
        players.add(Player(""));
      });
    }

    checkIfReadyToStart();
  }

  void checkIfReadyToStart() {
    int filledFields = 0;

    players.forEach((p) {
      if (p.name != "") filledFields += 1;
    });

    var oldReadyToStart = readyToStart;
    readyToStart = filledFields >= 2;

    bool doubleNames = false;
    players.forEach((Player p) {
      int i = 0;
      players.forEach((pl) {
        if (p.name != "" && p.name == pl.name) i++;
      });

      doubleNames = (i > 1) || doubleNames;
    });

    var oldShowMessageNoDoublePlayerNames = showMessageNoDoublePlayerNames;
    showMessageNoDoublePlayerNames = doubleNames;

    if (readyToStart != oldReadyToStart || showMessageNoDoublePlayerNames != oldShowMessageNoDoublePlayerNames)
      setState(() {
        readyToStart = filledFields >= 2 && !showMessageNoDoublePlayerNames;
        showMessageNoDoublePlayerNames = doubleNames;
      });
  }
}
