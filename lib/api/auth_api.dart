import 'dart:convert';

import 'package:mobile/api/api_client.dart';
import 'package:mobile/model/auth.dart';

abstract class AuthApi {
  Future<Auth> signUp(SignUpRequestBody body);

  Future<Auth> signIn(SignInRequestBody body);
}

class DefaultAuthApi extends AuthApi {
  DefaultAuthApi(this._client);

  final ApiClient _client;

  @override
  Future<Auth> signIn(SignInRequestBody body) async {
    final response = await _client.post(
      '/users/sign-in',
      body: json.encode(body),
    );
    print('Sign In Response: ${response.body}');
    return Auth.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  @override
  Future<Auth> signUp(SignUpRequestBody body) async {
    final response = await _client.post(
      '/users/sign-up',
      body: json.encode(body),
    );
    return Auth.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}
