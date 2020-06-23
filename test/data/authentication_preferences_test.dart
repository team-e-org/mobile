import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/data/authentication_preferences.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('AuthenticationPreferences test', () {
    MockSharedPreferences sp;
    AuthenticationPreferences prefs;

    setUp(() {
      sp = MockSharedPreferences();
      prefs = AuthenticationPreferences(prefs: sp);
    });

    test('getAccessToken', () {
      when(sp.getString('accessToken')).thenAnswer((realInvocation) => 'token');
      expect(prefs.getAccessToken(), equals('token'));
    });

    test('setAccessToken', () {
      when(sp.setString('accessToken', 'token'))
          .thenAnswer((_) => Future.value(true));
      expect(prefs.setAccessToken('token'), completion(equals(true)));
    });

    test('clearAccessToken', () {
      when(sp.remove('accessToken')).thenAnswer((_) => Future.value(true));
      expect(prefs.clearAccessToken(), completion(equals(true)));
    });

    test('getUserID', () {
      when(sp.getInt('userId')).thenAnswer((realInvocation) => 1);
      expect(prefs.getUserID(), equals(1));
    });

    test('setUserID', () {
      when(sp.setInt('userId', 1)).thenAnswer((_) => Future.value(true));
      expect(prefs.setUserID(1), completion(equals(true)));
    });

    test('clearUserID', () {
      when(sp.remove('userId')).thenAnswer((_) => Future.value(true));
      expect(prefs.clearUserID(), completion(equals(true)));
    });

    test('clearAll', () {
      when(sp.clear()).thenAnswer((_) => Future.value(true));
      expect(prefs.clearAll(), completion(equals(true)));
    });
  });
}
