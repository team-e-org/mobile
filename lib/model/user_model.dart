import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(includeIfNull: false)
class EditUser extends Equatable {
  const EditUser({
    this.name,
    this.email,
    this.icon,
  });

  final String name;
  final String email;
  final String icon;

  factory EditUser.fromJson(Map<String, dynamic> json) =>
      _$EditUserFromJson(json);

  factory EditUser.fromMock() => const EditUser(
        name: 'user',
        email: 'abc@example.com',
        icon: 'https://example.com/icon.png',
      );

  Map<String, dynamic> toJson() => _$EditUserToJson(this);

  @override
  List<Object> get props => [
        name,
        email,
        icon,
      ];
}

@JsonSerializable(includeIfNull: false)
class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final String icon;

  const User({
    this.id,
    this.name,
    this.email,
    this.icon,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromMock() => const User(
        id: 123,
        name: 'user name',
        email: 'email@mail.com',
        icon:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80',
      );

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object> get props => [
        id,
        name,
        email,
        icon,
      ];
}
