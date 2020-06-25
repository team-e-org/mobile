import 'package:flutter/material.dart';
import 'package:mobile/api/auth_api.dart';
import 'package:mobile/data/authentication_preferences.dart';
import 'package:mobile/model/auth.dart';

abstract class AccountRepository {
  Future<Auth> authenticate(String email, String password);

  Future<Auth> register(String username, String email, String password);

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
  final AuthenticationPreferences prefs;

  @override
  Future<Auth> authenticate(String email, String password) =>
      api.signIn(SignInRequestBody(email: email, password: password));

  @override
  Future<Auth> register(String username, String email, String password) =>
      api.signUp(SignUpRequestBody(
        name: username,
        email: email,
        password: password,
      ));

  @override
  Future<bool> hasToken() {
    final token = prefs.getAccessToken();
    final hasToken = token != null && token.isNotEmpty;
    return Future.value(hasToken);
  }

  @override
  Future<void> persistToken(String token) => prefs.setAccessToken(token);

  @override
  String getPersistToken() => prefs.getAccessToken();

  @override
  Future<void> deleteToken() => prefs.clearAccessToken();

  @override
  Future<void> persistUserId(int userId) => prefs.setUserID(userId);

  @override
  int getPersistUserId() => prefs.getUserID();

  @override
  Future<void> deleteUserId() => prefs.clearUserID();
}
