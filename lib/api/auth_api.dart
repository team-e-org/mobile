import 'dart:convert';

import 'package:mobile/api/api_client.dart';
import 'package:mobile/model/auth.dart';

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
    return Auth.fromJson(jsonDecode(response.body) as Map<String, dynamic>)
        .token;
  }
}
