import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationPreferences {
  const AuthenticationPreferences({
    @required this.prefs,
  });

  static const _accessToken = 'accessToken';
  static const _userID = 'userId';

  final SharedPreferences prefs;

  Future<String> getAccessToken() async {
    return prefs.getString(_accessToken);
  }

  Future setAccessToken(String value) async {
    await prefs.setString(_accessToken, value);
  }

  Future<int> getUserID() async {
    return prefs.getInt(_userID);
  }

  Future setUserID(int value) async {
    await prefs.setInt(_userID, value);
  }

  Future clear() async {
    await prefs.clear();
  }
}
