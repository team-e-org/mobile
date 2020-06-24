import 'package:mobile/model/auth.dart';
import 'package:mobile/repository/account_repository.dart';

class MockAccountRepository extends AccountRepository {
  @override
  Future<Auth> authenticate(String email, String password) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return const Auth(token: 'login token', userId: 1);
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
  Future<Auth> register(String username, String email, String password) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return const Auth(token: 'signin token', userId: 1);
  }
}
