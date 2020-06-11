import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(includeIfNull: false)
class EditUser {
  EditUser({
    this.name,
    this.email,
    this.icon,
  });

  final String name;
  final String email;
  final String icon;

  factory EditUser.fromJson(Map<String, dynamic> json) =>
      _$EditUserFromJson(json);

  Map<String, dynamic> toJson() => _$EditUserToJson(this);
}

@JsonSerializable(includeIfNull: false)
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

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  static User fromMock() {
    return User(
      id: 123,
      name: "user name",
      email: "email@mail.com",
      icon:
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80",
    );
  }
}
