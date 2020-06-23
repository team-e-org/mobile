import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationPreferences {
  static Future<AuthenticationPreferences> create() async {
    final prefs = await SharedPreferences.getInstance();
    return AuthenticationPreferences(prefs: prefs);
  }

  const AuthenticationPreferences({
    @required this.prefs,
  });

  static const _accessToken = 'accessToken';
  static const _userID = 'userId';

  final SharedPreferences prefs;

  String getAccessToken() {
    return prefs.getString(_accessToken);
  }

  Future setAccessToken(String value) async {
    await prefs.setString(_accessToken, value);
  }

  Future<bool> clearAccessToken() {
    return prefs.remove(_accessToken);
  }

  int getUserID() {
    return prefs.getInt(_userID);
  }

  Future setUserID(int value) async {
    await prefs.setInt(_userID, value);
  }

  Future<bool> clearUserID() {
    return prefs.remove(_userID);
  }

  Future clearAll() async {
    await prefs.clear();
  }
}
