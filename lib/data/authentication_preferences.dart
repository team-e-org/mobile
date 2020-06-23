import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationPreferences {
  const AuthenticationPreferences({
    @required this.prefs,
  });

  static const _accessToken = 'accessToken';
  static const _userID = 'userId';

  static Future<AuthenticationPreferences> create() async {
    final prefs = await SharedPreferences.getInstance();
    return AuthenticationPreferences(prefs: prefs);
  }

  final SharedPreferences prefs;

  String getAccessToken() => prefs.getString(_accessToken);

  Future<bool> setAccessToken(String value) =>
      prefs.setString(_accessToken, value);

  Future<bool> clearAccessToken() => prefs.remove(_accessToken);

  int getUserID() => prefs.getInt(_userID);

  Future<bool> setUserID(int value) => prefs.setInt(_userID, value);

  Future<bool> clearUserID() => prefs.remove(_userID);

  Future<bool> clearAll() => prefs.clear();
}
