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

  // TODO
  // factory Board fromJson(Map<String, dynamic> json){}

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
