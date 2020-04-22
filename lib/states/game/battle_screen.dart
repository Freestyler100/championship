class battleScreen {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue, Colors.white])),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                Column(children: [
                  Text('[Spieler]', style: TextStyle(fontSize: 30, color: Colors.white)),
                  Text('Wähle weise...', style: TextStyle(fontSize: 30))
                ]),
                Container(
                  child: OutlineButton(
                    onPressed: () => Navigator.of(context).pushNamed('/third'),
                    borderSide: BorderSide(width: 3, color: Colors.black),
                    highlightedBorderColor: Colors.black,
                    child: Image.asset('assets/images/paper.png', width: 100),
                  ),
                ),
                Container(
                  child: OutlineButton(
                    onPressed: () => Navigator.of(context).pushNamed('/third'),
                    borderSide: BorderSide(width: 3, color: Colors.black),
                    highlightedBorderColor: Colors.black,
                    child: Image.asset('assets/images/rock.png', width: 100),
                  ),
                ),
                Container(
                  child: OutlineButton(
                    onPressed: () => Navigator.of(context).pushNamed('/third'),
                    borderSide: BorderSide(width: 3, color: Colors.black),
                    highlightedBorderColor: Colors.black,
                    child:
                        Image.asset('assets/images/scissors.png', width: 100),
                  ),
                )
              ]))),
    );
  }
}
