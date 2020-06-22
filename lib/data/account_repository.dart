import 'package:flutter/material.dart';
import 'package:mobile/api/auth_api.dart';
import 'package:mobile/model/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

const TOKEN_KEY = 'token';

abstract class AccountRepository {
  Future<String> authenticate(String email, String password);

  Future<String> register(String username, String email, String password);

  Future<void> deleteToken();

  Future<void> persistToken(String token);

  Future<bool> hasToken();
}

class DefaultAccountRepository extends AccountRepository {
  DefaultAccountRepository({
    @required this.api,
    @required this.prefs,
  });

  final AuthApi api;
  final SharedPreferences prefs;

  @override
  Future<String> authenticate(String email, String password) =>
      api.signIn(SignInRequestBody(email: email, password: password));

  @override
  Future<void> deleteToken() => prefs.remove(TOKEN_KEY);

  @override
  Future<bool> hasToken() {
    final token = prefs.getString(TOKEN_KEY);
    final hasToken = token != null && token.isNotEmpty;
    return Future.value(hasToken);
  }

  @override
  Future<void> persistToken(String token) => prefs.setString(TOKEN_KEY, token);

  @override
  Future<String> register(String username, String email, String password) =>
      api.signUp(SignUpRequestBody(
        name: username,
        email: email,
        password: password,
      ));
}

class MockAccountRepository extends AccountRepository {
  @override
  Future<String> authenticate(String email, String password) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return 'login token';
  }

  @override
  Future<void> deleteToken() async {
    await Future<void>.delayed(const Duration(seconds: 1));
  }

  @override
  Future<bool> hasToken() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return false;
  }

  @override
  Future<void> persistToken(String token) async {
    await Future<void>.delayed(const Duration(seconds: 1));
  }

  @override
  Future<String> register(
      String username, String email, String password) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return 'login token';
  }
}
