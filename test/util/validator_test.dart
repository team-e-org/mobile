import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/util/validator.dart';

class TestCase {
  const TestCase(this.description, this.value, this.expect);

  final String description;
  final String value;
  final bool expect;
}

void main() {
  group('validator test', () {
    test('isValidEmail test', () {
      const cases = <TestCase>[
        TestCase('valid email', 'abc@example.com', true),
        TestCase('invalid email', 'abcexamplecom', false),
      ];

      for (final c in cases) {
        expect(Validator.isValidEmail(c.value), equals(c.expect));
      }
    });

    test('isValidPassword test', () {
      const cases = <TestCase>[
        TestCase('too short', 'Aa9876543', false),
        TestCase('no lower alphabet', 'A987654321', false),
        TestCase('no upper alphabet', 'a987654321', false),
        TestCase('no digit', 'Aabcdefghi', false),
        TestCase('valid password', 'Aa98765432', true),
      ];

      for (final c in cases) {
        expect(Validator.isValidPassword(c.value), equals(c.expect));
      }
    });

    test('isValidBoardName test', () {
      final cases = <TestCase>[
        const TestCase('null', null, false),
        const TestCase('empty', '', true),
        const TestCase('valid board name1', 'board', true),
        TestCase('valid board name2', '1' * 30, true),
        TestCase('too long board name', '1' * 31, false),
      ];

      for (final c in cases) {
        expect(Validator.isValidBoardName(c.value), equals(c.expect));
      }
    });

    test('isValidPinTitle test', () {
      final cases = <TestCase>[
        const TestCase('null', null, false),
        const TestCase('empty', '', true),
        const TestCase('valid pin name1', 'pin', true),
        TestCase('valid pin name2', '1' * 30, true),
        TestCase('too long pin name', '1' * 31, false),
      ];

      for (final c in cases) {
        expect(Validator.isValidPinTitle(c.value), equals(c.expect));
      }
    });

    test('isValidPinDescription test', () {
      final cases = <TestCase>[
        const TestCase('null', null, false),
        const TestCase('empty', '', true),
        const TestCase('valid pin name1', 'pin description', true),
        TestCase('valid pin name2', '1' * 280, true),
        TestCase('too long pin name', '1' * 281, false),
      ];

      for (final c in cases) {
        expect(Validator.isValidPinDescription(c.value), equals(c.expect));
      }
    });

    test('is valid pin url test', () {
      const cases = <TestCase>[
        TestCase('valid url', 'https://example.com/articles/1', true),
        TestCase('invalid url', 'https//example.com/articles/1', false),
      ];

      for (final c in cases) {
        expect(Validator.isValidPinUrl(c.value), equals(c.expect));
      }
    });
  });
}
