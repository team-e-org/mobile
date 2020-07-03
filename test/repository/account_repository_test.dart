import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/api/auth_api.dart';
import 'package:mobile/data/authentication_preferences.dart';
import 'package:mobile/model/auth.dart';
import 'package:mobile/repository/account_repository.dart';
import 'package:mockito/mockito.dart';

class MockAuthApi extends Mock implements AuthApi {}

class MockAuthenticationPreferences extends Mock
    implements AuthenticationPreferences {}

void main() {
  group('account repository test', () {
    MockAuthApi api;
    MockAuthenticationPreferences prefs;
    AccountRepository repo;

    setUp(() {
      api = MockAuthApi();
      prefs = MockAuthenticationPreferences();
      repo = DefaultAccountRepository(
        api: api,
        prefs: prefs,
      );
    });

    test('authenticate', () async {
      const expected = Auth(token: 'token', userId: 1);
      when(api.signIn(any)).thenAnswer((_) => Future.value(expected));

      final actual = await repo.authenticate('abc@example.com', 'password');

      expect(actual, equals(expected));
    });

    test('register', () async {
      const expected = Auth(token: 'token', userId: 1);
      when(api.signUp(any)).thenAnswer((_) => Future.value(expected));

      final actual = await repo.register(
        'username',
        'abc@example.com',
        'password',
      );

      expect(actual, equals(expected));
    });

    test('hasToken', () async {
      when(prefs.getAccessToken()).thenReturn('token');

      final actual = await repo.hasToken();

      expect(actual, equals(true));
    });

    test('persist token', () async {
      String token;

      when(prefs.setAccessToken(any)).thenAnswer((invocation) async {
        token = invocation.positionalArguments.elementAt(0) as String;
        return true;
      });

      await repo.persistToken('token');

      expect(token, 'token');
    });

    test('get persist token', () {
      when(prefs.getAccessToken()).thenReturn('token');

      final actual = repo.getPersistToken();

      expect(actual, equals('token'));
    });

    test('delete token', () async {
      var token = 'token';
      when(prefs.clearAccessToken()).thenAnswer((realInvocation) async {
        token = '';
        return true;
      });

      await repo.deleteToken();

      expect(token, equals(''));
    });

    test('persist user id', () async {
      int userID;

      when(prefs.setUserID(any)).thenAnswer((realInvocation) async {
        userID = realInvocation.positionalArguments.elementAt(0) as int;
        return true;
      });

      await repo.persistUserId(123);

      expect(userID, equals(123));
    });

    test('get persist user id', () {
      when(prefs.getUserID()).thenReturn(123);

      final actual = repo.getPersistUserId();

      expect(actual, equals(123));
    });

    test('delete user id', () {
      var userID = 123;

      when(prefs.clearUserID()).thenAnswer((_) async {
        userID = null;
        return true;
      });

      repo.deleteUserId();

      expect(userID, isNull);
    });
  });
}
