import 'package:flutter/material.dart';
import 'package:mobile/api/users_api.dart';

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
  });

  final UsersApi api;

  @override
  Future<String> authenticate(String email, String password) {
    // TODO: implement authenticate
    throw UnimplementedError();
  }

  @override
  Future<void> deleteToken() {
    // TODO: implement deleteToken
    throw UnimplementedError();
  }

  @override
  Future<bool> hasToken() {
    // TODO: implement hasToken
    throw UnimplementedError();
  }

  @override
  Future<void> persistToken(String token) {
    // TODO: implement persistToken
    throw UnimplementedError();
  }

  @override
  Future<String> register(String username, String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }
}

class MockAccountRepository extends AccountRepository {
  @override
  Future<String> authenticate(String email, String password) async {
    await Future<void>.delayed(Duration(seconds: 1));
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
