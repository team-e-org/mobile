import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/model/auth.dart';

void main() {
  group('Auth model test', () {
    test('fromJson', () {
      final expected = Auth.fromMock();
      final actual = Auth.fromJson(expected.toJson());
      expect(actual, equals(expected));
    });
    test('toJson', () {
      const auth = Auth(token: 'token', userId: 0);
      final expected = {
        'token': 'token',
        'user_id': 0,
      };
      final actual = auth.toJson();
      expect(actual, equals(expected));
    });
  });

  group('AuthResponse model test', () {
    test('fromJson', () {
      final expected = AuthResponse.fromMock();
      final actual = AuthResponse.fromJson(expected.toJson());
      expect(actual, equals(expected));
    });
    test('toJson', () {
      const ar = AuthResponse(token: 'token', userId: 0);
      final expected = {
        'token': 'token',
        'user_id': 0,
      };
      final actual = ar.toJson();
      expect(actual, equals(expected));
    });
  });

  group('AuthResponse model test', () {
    test('fromJson', () {
      final expected = AuthResponse.fromMock();
      final actual = AuthResponse.fromJson(expected.toJson());
      expect(actual, equals(expected));
    });
    test('toJson', () {
      const ar = AuthResponse(token: 'token', userId: 0);
      final expected = {
        'token': 'token',
        'user_id': 0,
      };
      final actual = ar.toJson();
      expect(actual, equals(expected));
    });
  });

  group('SignUpRequestBody model test', () {
    test('fromJson', () {
      final expected = SignUpRequestBody.fromMock();
      final actual = SignUpRequestBody.fromJson(expected.toJson());
      expect(actual, equals(expected));
    });
    test('toJson', () {
      const srb = SignUpRequestBody(
        name: 'user',
        email: 'abc@example.com',
        password: 'password',
      );
      final expected = {
        'name': 'user',
        'email': 'abc@example.com',
        'password': 'password',
      };

      final actual = srb.toJson();
      expect(actual, equals(expected));
    });
  });

  group('SignInRequestBody model test', () {
    test('fromJson', () {
      final expected = SignInRequestBody.fromMock();
      final actual = SignInRequestBody.fromJson(expected.toJson());
      expect(actual, equals(expected));
    });
    test('toJson', () {
      const srb = SignInRequestBody(
        email: 'abc@example.com',
        password: 'password',
      );
      final expected = {
        'email': 'abc@example.com',
        'password': 'password',
      };

      final actual = srb.toJson();
      expect(actual, equals(expected));
    });
  });
}
