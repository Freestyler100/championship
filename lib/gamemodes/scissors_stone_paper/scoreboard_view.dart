import 'package:championship/constants.dart';
import 'package:championship/gamemodes/scissors_stone_paper/round_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SSPScoreboardView extends StatelessWidget {
  final List<RoundResult> roundResults;
  final Function(int state) continueCallback;

  const SSPScoreboardView(this.roundResults, this.continueCallback, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.blue, Colors.white])),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Image.asset('assets/images/trophy.png', width: 100),
            ),
            Text('${roundResults.last.winner.name}', style: TextStyle(fontSize: 30)),
            Text('hat das Turnier gewonnen!', style: TextStyle(fontSize: 30)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(roundResults.last.layer + 1, (index) {
                print(roundResults.where((element) => element.layer == index).length);

                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: roundResults.where((element) => element.layer == index).map((e) {
                      if (e.player2 != null)
                        return Container(
                          alignment: Alignment.center,
                          width: 150,
                          child: Column(
                            children: [
                              // Row(
                              //   mainAxisSize: MainAxisSize.max,
                              //   children: [
                              //     gestureToImage(e.winner.gesture),
                              //     Spacer(flex: 1),
                              //     Text(" - "),
                              //     Spacer(flex: 1),
                              //     gestureToImage(e.loser.gesture)
                              //   ],
                              // ),
                              Row(
                                children: [
                                  gestureToImage(e.winner.gesture),
                                  Expanded(
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: e.winner.name,
                                        style: TextStyle(color: Colors.green),
                                        children: [
                                          TextSpan(
                                            text: ' vs. ',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          TextSpan(
                                            text: e.loser.name,
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  gestureToImage(e.loser.gesture),
                                ],
                              ),
                            ],
                          ),
                        );
                      else
                        return Container(
                          alignment: Alignment.center,
                          width: 100,
                          child: Text(e.player1.name),
                        );
                    }).toList(),
                  ),
                );
              }).reversed.toList(),
            ),
            Spacer(
              flex: 1,
            ),
            FlatButton(
              onPressed: () {
                continueCallback(APPSTATE.SELECT_PLAYERS_STATE);
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(border: Border.all(color: Colors.orange, width: 3)),
                child: Text("Zurück zur Spielerauswahl"),
              ),
            ),
            FlatButton(
              onPressed: () {
                continueCallback(APPSTATE.GAME_STATE);
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(border: Border.all(color: Colors.orange, width: 3)),
                child: Text("Noch eine Runde"),
              ),
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    ));
  }

  Image gestureToImage(int gesture) {
    switch (gesture) {
      case 0:
        return Image.asset('assets/images/scissors.png', width: 20);
        break;
      case 1:
        return Image.asset('assets/images/rock.png', width: 20);
        break;
      case 2:
        return Image.asset('assets/images/paper.png', width: 20);
        break;
    }
    return null;
  }
}
