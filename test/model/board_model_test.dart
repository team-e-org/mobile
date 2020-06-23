import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/model/board_model.dart';

void main() {
  group('NewBoard model test', () {
    test('fromJson', () {
      final expected = NewBoard.fromMock();
      final actual = NewBoard.fromJson(expected.toJson());
      expect(actual, equals(expected));
    });
    test('toJson', () {
      const nb = NewBoard(
        name: 'my board',
        description: 'board description',
        isPrivate: true,
      );
      final expected = {
        'name': 'my board',
        'description': 'board description',
        'isPrivate': true,
      };
      final actual = nb.toJson();
      expect(actual, equals(expected));
    });
  });

  group('EditBoard model test', () {
    test('fromJson', () {
      final expected = EditBoard.fromMock();
      final actual = EditBoard.fromJson(expected.toJson());
      expect(actual, equals(expected));
    });
    test('toJson', () {
      const eb = EditBoard(
        name: 'my board',
        description: 'board description',
        isPrivate: true,
        isArchive: true,
      );
      final expected = {
        'name': 'my board',
        'description': 'board description',
        'isPrivate': true,
        'isArchive': true,
      };
      final actual = eb.toJson();
      expect(actual, equals(expected));
    });
  });

  group('Board model test', () {
    test('fromJson', () {
      final expected = Board.fromMock();
      final actual = Board.fromJson(expected.toJson());
      expect(actual, equals(expected));
    });
    test('toJson', () {
      const b = Board(
        id: 0,
        userId: 0,
        name: 'board',
        description: 'board description',
        isPrivate: false,
        isArchive: false,
      );
      final expected = {
        'id': 0,
        'userId': 0,
        'name': 'board',
        'description': 'board description',
        'isPrivate': false,
        'isArchive': false,
      };

      final actual = b.toJson();
      expect(actual, equals(expected));
    });
  });
}
