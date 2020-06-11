class Board {
  final int id;
  final int userId;
  final String name;
  final String description;
  final bool isPrivate;
  final bool isArchive;

  Board({
    this.id,
    this.userId,
    this.name,
    this.description,
    this.isPrivate,
    this.isArchive,
  });

  Board.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        userId = json['userId'] as int,
        name = json['name'],
        description = json['description'],
        isPrivate = json['isPrivate'],
        isArchive = json['isArchive'];

  static Board fromMock() {
    return Board(
      id: 1234,
      userId: 143,
      name: "board name",
      description: "description",
      isPrivate: false,
      isArchive: false,
    );
  }
}
