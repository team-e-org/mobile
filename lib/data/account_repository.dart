abstract class AccountRepository {
  Future<String> authenticate(String email, String password);

  Future<String> register(String username, String email, String password);

  Future<void> deleteToken();

  Future<void> persistToken(String token);

  Future<bool> hasToken();
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
