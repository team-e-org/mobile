import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable(includeIfNull: false)
class Auth extends Equatable {
  const Auth({
    this.token,
    this.userId,
  });

  final String token;
  @JsonKey(name: 'user_id')
  final int userId;

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);

  factory Auth.fromMock() => const Auth(token: 'token', userId: 0);

  Map<String, dynamic> toJson() => _$AuthToJson(this);

  @override
  List<Object> get props => [token, userId];
}

@JsonSerializable(includeIfNull: false)
class AuthResponse extends Equatable {
  const AuthResponse({
    this.token,
    this.userId,
  });

  final String token;
  @JsonKey(name: 'user_id')
  final int userId;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  factory AuthResponse.fromMock() =>
      const AuthResponse(token: 'token', userId: 0);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);

  @override
  List<Object> get props => [token, userId];
}

@JsonSerializable(includeIfNull: false)
class SignUpRequestBody extends Equatable {
  const SignUpRequestBody({
    @required this.name,
    @required this.email,
    @required this.password,
  });

  final String name;
  final String email;
  final String password;

  factory SignUpRequestBody.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestBodyFromJson(json);

  factory SignUpRequestBody.fromMock() => const SignUpRequestBody(
        name: 'user',
        email: 'abc@example.com',
        password: 'password',
      );

  Map<String, dynamic> toJson() => _$SignUpRequestBodyToJson(this);

  @override
  List<Object> get props => [name, email, password];
}

@JsonSerializable(includeIfNull: false)
class SignInRequestBody extends Equatable {
  const SignInRequestBody({
    @required this.email,
    @required this.password,
  });

  final String email;
  final String password;

  factory SignInRequestBody.fromJson(Map<String, dynamic> json) =>
      _$SignInRequestBodyFromJson(json);

  factory SignInRequestBody.fromMock() =>
      const SignInRequestBody(email: 'abc@example.com', password: 'password');

  Map<String, dynamic> toJson() => _$SignInRequestBodyToJson(this);

  @override
  List<Object> get props => [email, password];
}
