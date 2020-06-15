abstract class UserRepository {
  Future<String> authenticate(String email, String password);

  Future<String> register(String username, String email, String password);

  Future<void> deleteToken();

  Future<void> persistToken(String token);

  Future<bool> hasToken();
}
