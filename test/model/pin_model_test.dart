import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/model/pin_model.dart';

void main() {
  group('NewPin model test', () {
    test('fromJson', () {
      final expected = NewPin.fromMock();
      final actual = NewPin.fromJson(expected.toJson());
      expect(actual, equals(expected));
    });
    test('toJson', () {
      const np = NewPin(
        title: 'pin',
        description: 'pin description',
        url: 'https://example.com',
        isPrivate: false,
      );
      final expected = {
        'title': 'pin',
        'description': 'pin description',
        'url': 'https://example.com',
        'isPrivate': false,
      };
      final actual = np.toJson();
      expect(actual, equals(expected));
    });
  });

  group('EditPin model test', () {
    test('fromJson', () {
      final expected = EditPin.fromMock();
      final actual = EditPin.fromJson(expected.toJson());
      expect(actual, equals(expected));
    });
    test('toJson', () {
      const ep = EditPin(
        title: 'pin',
        description: 'pin description',
        isPrivate: false,
      );
      final expected = {
        'title': 'pin',
        'description': 'pin description',
        'isPrivate': false,
      };
      final actual = ep.toJson();
      expect(actual, equals(expected));
    });
  });

  group('Pin model test', () {
    test('fromJson', () {
      final expected = Pin.fromMock();
      final actual = Pin.fromJson(expected.toJson());
      expect(actual, equals(expected));
    });
    test('toJson', () {
      const p = Pin(
        id: 0,
        title: 'my pin',
        description: 'pin description',
        url: 'https://example.com',
        userId: 0,
        imageUrl: 'https://example.com/image.png',
        isPrivate: false,
      );
      final expected = {
        'id': 0,
        'title': 'my pin',
        'description': 'pin description',
        'url': 'https://example.com',
        'userId': 0,
        'imageUrl': 'https://example.com/image.png',
        'isPrivate': false,
      };
      final actual = p.toJson();
      expect(actual, equals(expected));
    });
  });
}
