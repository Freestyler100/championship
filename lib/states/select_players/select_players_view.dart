import 'package:champion_chip/components/inherited_player_list.dart';
import 'package:champion_chip/components/player.dart';
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

  @override
  void initState() {
    readyToStart = false;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    players = InheritedPlayerList.of(context).service.players.toList();

    while (players.length < 2) {
      players.add(Player(""));
    }

    print("start : " + players.toString());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: (readyToStart
                ? () {
                    startGame(context);
                  }
                : null),
          )),
      body: Column(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: (players.length >= 2 ? players.length : 2),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.only(left: 16),
                height: 50,
                child: Center(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      onEditingComplete: () {
                        print("submitted");
                      },
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
    );
  }

  void startGame(BuildContext context) {
    //remove empty textfields and set global InheritedPlayerList to new players
    List<Player> tmpPlayers = [];
    players.forEach((p) {
      if (p.name != "") tmpPlayers.add(p);
    });
    InheritedPlayerList.of(context).service.players = tmpPlayers.toList();
    print("new " + InheritedPlayerList.of(context).service.players.toString());

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

    if (readyToStart != oldReadyToStart)
      setState(() {
        readyToStart = filledFields >= 2;
      });
  }
}
