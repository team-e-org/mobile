class User {
  final int id;
  final String name;
  final String email;
  final String icon;

  User({
    this.id,
    this.name,
    this.email,
    this.icon,
  });

  // TODO
  // factory User fromJson(Map<String, dynamic> json){}

  static User fromMock() {
    return User(
      id: 123,
      name: "user name",
      email: "email@mail.com",
      icon: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80",
    );
  }
}
