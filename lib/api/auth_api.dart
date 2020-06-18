import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/api/api_client.dart';

part 'auth_api.g.dart';

abstract class AuthApi {
  Future<String> signUp(SignUpRequestBody body);

  Future<String> signIn(SignInRequestBody body);
}

class DefaultAuthApi extends AuthApi {
  DefaultAuthApi(this._client);

  final ApiClient _client;

  @override
  Future<String> signIn(SignInRequestBody body) async {
    final response = await _client.post(
      '/users/sign-in',
      body: json.encode(body),
    );
    return AuthResponse.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>)
        .token;
  }

  @override
  Future<String> signUp(SignUpRequestBody body) async {
    final response = await _client.post(
      '/users/sign-up',
      body: json.encode(body),
    );
    return AuthResponse.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>)
        .token;
  }
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

@JsonSerializable(includeIfNull: false)
class AuthResponse {
  AuthResponse({
    @required this.token,
  });

  String token;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
