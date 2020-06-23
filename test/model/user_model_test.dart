import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/model/models.dart';

void main() {
  group('EditUser model test', () {
    test('fromJson', () {
      final expected = EditUser.fromMock();
      final actual = EditUser.fromJson(expected.toJson());
      expect(actual, equals(expected));
    });
    test('toJson', () {
      const eu = EditUser(
        name: 'user',
        email: 'abc@example.com',
        icon: 'https://example.com/icon.png',
      );
      final expected = {
        'name': 'user',
        'email': 'abc@example.com',
        'icon': 'https://example.com/icon.png',
      };
      final actual = eu.toJson();
      expect(actual, equals(expected));
    });
  });

  group('User model test', () {
    test('fromJson', () {
      final expected = User.fromMock();
      final actual = User.fromJson(expected.toJson());
      expect(actual, equals(expected));
    });
    test('toJson', () {
      const eu = User(
        id: 0,
        name: 'user',
        email: 'abc@example.com',
        icon: 'https://example.com/icon.png',
      );
      final expected = {
        'id': 0,
        'name': 'user',
        'email': 'abc@example.com',
        'icon': 'https://example.com/icon.png',
      };
      final actual = eu.toJson();
      expect(actual, equals(expected));
    });
  });
}
