class handoverScreen {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.white])
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('[Spieler] ist jetzt dran.', style: TextStyle(fontSize: 30)),
                  Text('Bitte reichen Sie das Gerät weiter.', style: TextStyle(fontSize: 22)),
                ]
              ),
            Container(
              child: OutlineButton(
                onPressed: () => Navigator.of(context).pushNamed('/second'),
                borderSide: BorderSide(width: 3, color: Colors.black),
                highlightedBorderColor: Colors.black,
                child: Text('Los geht\'s!', style: TextStyle(fontSize: 30, color: Colors.blue)))
            )

          ],
        )
        )
      )

    );
  }
}
