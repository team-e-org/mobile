class Pin {
  final int id;
  final String title;
  final String description;
  final String url;
  final int userId;
  final String imageUrl;
  final bool isPrivate;

  Pin({
    this.id,
    this.title,
    this.description,
    this.url,
    this.userId,
    this.imageUrl,
    this.isPrivate,
  });

  // TODO
  // factory Pin fromJson(Map<String, dynamic> json){}

  static Pin fromMock() {
    return Pin(
      id: 123,
      title: "title",
      description: "description",
      url: "http://www.sample.com",
      userId: 143,
      imageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80",
      isPrivate: false,
    );
  }
}
