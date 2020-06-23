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
  factory DefaultAccountRepository({
    @required AuthApi api,
    @required AuthenticationPreferences prefs,
  }) {
    return _instance ?? DefaultAccountRepository._internal(api, prefs);
  }

  DefaultAccountRepository._internal(this._api, this._prefs);

  static DefaultAccountRepository _instance;

  final AuthApi _api;
  final AuthenticationPreferences _prefs;

  @override
  Future<Auth> authenticate(String email, String password) =>
      _api.signIn(SignInRequestBody(email: email, password: password));

  @override
  Future<Auth> register(String username, String email, String password) =>
      _api.signUp(SignUpRequestBody(
        name: username,
        email: email,
        password: password,
      ));

  @override
  Future<bool> hasToken() {
    final token = _prefs.getAccessToken();
    final hasToken = token != null && token.isNotEmpty;
    return Future.value(hasToken);
  }

  @override
  Future<void> persistToken(String token) => _prefs.setAccessToken(token);

  @override
  String getPersistToken() => _prefs.getAccessToken();

  @override
  Future<void> deleteToken() => _prefs.clearAccessToken();

  @override
  Future<void> persistUserId(int userId) => _prefs.setUserID(userId);

  @override
  int getPersistUserId() => _prefs.getUserID();

  @override
  Future<void> deleteUserId() => _prefs.clearUserID();
}