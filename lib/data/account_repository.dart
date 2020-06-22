import 'package:flutter/material.dart';
import 'package:mobile/api/auth_api.dart';
import 'package:mobile/model/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

const TOKEN_KEY = 'token';
const USERID_KEY = 'userId';

abstract class AccountRepository {
  Future<String> authenticate(String email, String password);

  Future<String> register(String username, String email, String password);

  Future<void> persistToken(String token);
  String getPersistToken();
  Future<void> deleteToken();

  Future<void> persistUserId(int userId);
  int getPersistUserId();
  Future<void> deleteUserId();

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
  Future<bool> hasToken() {
    final token = prefs.getString(TOKEN_KEY);
    final hasToken = token != null && token.isNotEmpty;
    return Future.value(hasToken);
  }

  @override
  Future<void> persistToken(String token) => prefs.setString(TOKEN_KEY, token);

  @override
  String getPersistToken() {
    return prefs.getString(TOKEN_KEY);
  }

  @override
  Future<void> deleteToken() => prefs.remove(TOKEN_KEY);

  @override
  Future<void> persistUserId(int userId) =>
      prefs.setString(USERID_KEY, userId.toString());

  @override
  int getPersistUserId() {
    return int.parse(prefs.getString(USERID_KEY));
  }

  @override
  Future<void> deleteUserId() => prefs.remove(USERID_KEY);

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
  String getPersistToken() {
    return 'x-auth-token';
  }

  @override
  Future<void> persistUserId(int userId) async {
    await Future<void>.delayed(const Duration(seconds: 1));
  }

  @override
  int getPersistUserId() {
    return 1;
  }

  @override
  Future<void> deleteUserId() async {
    await Future<void>.delayed(const Duration(seconds: 1));
  }

  @override
  Future<String> register(
      String username, String email, String password) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return 'login token';
  }
}
