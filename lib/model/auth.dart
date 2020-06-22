import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable(includeIfNull: false)
class Auth {
  Auth({
    this.token,
    this.userId,
  });

  final String token;
  @JsonKey(name: 'user_id')
  final int userId;

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);
  Map<String, dynamic> toJson() => _$AuthToJson(this);
}

@JsonSerializable(includeIfNull: false)
class AuthResponse {
  AuthResponse({
    this.token,
    this.userId,
  });

  final String token;
  @JsonKey(name: 'user_id')
  final int userId;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class SignUpRequestBody {
  SignUpRequestBody({
    @required this.name,
    @required this.email,
    @required this.password,
  });

  String name;
  String email;
  String password;

  factory SignUpRequestBody.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpRequestBodyToJson(this);
}

@JsonSerializable(includeIfNull: false)
class SignInRequestBody {
  SignInRequestBody({
    @required this.email,
    @required this.password,
  });

  String email;
  String password;

  factory SignInRequestBody.fromJson(Map<String, dynamic> json) =>
      _$SignInRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SignInRequestBodyToJson(this);
}
