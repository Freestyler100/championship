class Player {
  static int _nextId = 0;
  int _id;
  String name;

  Player(this.name, {int id}) {
    if (id != null)
      _id = id;
    else {
      _id = _nextId;
      _nextId++;
    }
  }

  get id => _id;
}
